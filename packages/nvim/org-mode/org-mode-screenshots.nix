# Insert images/screenshots functionality
{ lib, pkgs, ... }: {
  vim.luaConfigRC.orgModeScreenshots = ''
    -- Required telescope modules
    local telescope = require('telescope')
    local pickers = require('telescope.pickers')
    local finders = require('telescope.finders')
    local conf = require('telescope.config').values
    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')
    local previewers = require('telescope.previewers')

    local function insert_screenshot_link()
      local screenshots_dir = vim.fn.expand(os.getenv("SCREENSHOTS") or "~/screenshots")

      -- Get all image files with their modification times
      local files = {}
      local handle = io.popen('ls -1t "' .. screenshots_dir .. '" | grep -E "\\.(png|jpg|jpeg|gif|bmp|PNG|JPG|JPEG|GIF|BMP)$"')
      if handle then
        for filename in handle:lines() do
          table.insert(files, {
            filename = filename,
            display = filename,
            path = screenshots_dir .. filename
          })
        end
        handle:close()
      end
      
      if #files == 0 then
        print("No image files found in screenshots folder")
        return
      end
      
      -- Show telescope picker
      pickers.new({}, {
        prompt_title = "Insert Screenshot (newest first)",
        finder = finders.new_table {
          results = files,
          entry_maker = function(entry)
            return {
              value = entry,
              display = entry.display,
              ordinal = entry.filename,
            }
          end,
        },
        sorter = conf.generic_sorter({}),
        previewer = previewers.new_termopen_previewer({
          get_command = function(entry)
            -- Try to use different image preview commands
            if vim.fn.executable('viu') == 1 then
              return { 'viu', entry.value.path }
            elseif vim.fn.executable('catimg') == 1 then
              return { 'catimg', '-w', '100', entry.value.path }
            else
              -- Fallback to file info if no image viewer available
              return { 'file', entry.value.path }
            end
          end,
        }),
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            
            if selection then
              -- Insert org-mode image link at cursor position
              local link = "[[file:" .. selection.value.path .. "]]"
              
              -- Get current cursor position
              local row, col = unpack(vim.api.nvim_win_get_cursor(0))
              
              -- Insert the link at cursor position
              local current_line = vim.api.nvim_get_current_line()
              local new_line = current_line:sub(1, col) .. link .. current_line:sub(col + 1)
              vim.api.nvim_set_current_line(new_line)
              
              -- Move cursor to end of inserted link
              vim.api.nvim_win_set_cursor(0, {row, col + #link})
              
              print("Inserted image: " .. selection.value.filename)
            end
          end)
          return true
        end,
      }):find()
    end

    -- Set up keymap for inserting screenshots
    vim.keymap.set('n', '<leader>msi', insert_screenshot_link, { 
      desc = "Insert screenshot link",
      silent = true 
    })
  '';
}
