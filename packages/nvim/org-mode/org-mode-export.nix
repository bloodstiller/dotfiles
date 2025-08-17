# Export functionality (Hugo markdown export)
{ lib, pkgs, ... }: {
  vim.luaConfigRC.orgModeExport = ''
    -- Function to export to markdown hugo
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "org",
      callback = function()
        vim.keymap.set('n', '<leader>neh', function()
          local current_file = vim.api.nvim_buf_get_name(0)
          local target = vim.fn.fnamemodify(current_file, ':p:r')..'.md'
          
          -- Pandoc command with Hugo-friendly options
          local command = {
            'pandoc',
            current_file,
            '-f', 'org',
            '-t', 'markdown',
            '--wrap=none',
            '--standalone',
            '--shift-heading-level-by=1',
            '-o', target
          }
          
          print("Exporting to: " .. target)
          
          -- Run the export command
          vim.fn.jobstart(command, {
            on_exit = function(_, code)
              if code == 0 then
                -- Post-process the file
                local content = vim.fn.readfile(target)
                local processed = {}
                local in_frontmatter = false
                
                for i, line in ipairs(content) do
                  if i == 1 and line:match('^%-%-%-$') then
                    in_frontmatter = true
                    table.insert(processed, line)
                  elseif in_frontmatter and line:match('^%.%.%.$') then
                    in_frontmatter = false
                    table.insert(processed, '---')
                  elseif in_frontmatter then
                    line = line:gsub('^title: "?(.+)"?$', 'title: "%1"')
                    line = line:gsub('^date: (%d+-%d+-%d+)', 'date: %1')
                    table.insert(processed, line)
                  else
                    table.insert(processed, line)
                  end
                end
                
                vim.fn.writefile(processed, target)
                
                print('Exported to Hugo markdown: ' .. target)
                vim.ui.input({
                  prompt = 'Open exported file? (y/n): ',
                }, function(input)
                  if input and input:lower() == 'y' then
                    vim.cmd('edit ' .. target)
                  end
                end)
              else
                print('Export failed! Exit code: ' .. code)
              end
            end,
            on_stderr = function(_, data)
              if data and #data > 0 and data[1] ~= "" then
                print('Error: ' .. table.concat(data, '\n'))
              end
            end,
          })
        end, { buffer = true, desc = "Export to Hugo Markdown" })
      end,
    })
  '';
}
