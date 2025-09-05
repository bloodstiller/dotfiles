# Easy refile functionality
{ lib, pkgs, ... }: {
  vim.luaConfigRC.orgModeRefile = ''
    -- Read environment variables FOR ORG and expand tilde
    local org_folder = vim.fn.expand(os.getenv("ORGFOLDER") or "~/Org")


    -- Required telescope modules for refile
    local telescope = require('telescope')
    local pickers = require('telescope.pickers')
    local finders = require('telescope.finders')
    local conf = require('telescope.config').values
    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')

    -- Function to refile current heading to a location in your main todo file
    local function refile_to_main_todo()
      -- Path to your main todo file (references var above)
      local main_todo_file = org_folder .. "/01-Emacs/01.02-OrgGtd/org-gtd-tasks.org"
      
      -- Get the current heading and its content
      local current_line_num = vim.fn.line('.')
      local current_line = vim.api.nvim_get_current_line()
      
      -- Check if we're on a heading
      if not current_line:match("^%*+%s") then
        print("Not on a heading")
        return
      end
      
      -- Determine the level of the current heading
      local current_level = #current_line:match("^(%*+)")
      
      -- Get all lines of the current heading and its content
      local heading_lines = {current_line}
      local line_num = current_line_num + 1
      local total_lines = vim.fn.line('$')
      
      -- Collect all lines until the next heading of same or higher level
      while line_num <= total_lines do
        local line = vim.fn.getline(line_num)
        local next_heading = line:match("^(%*+)%s")
        
        if next_heading and #next_heading <= current_level then
          break
        end
        
        table.insert(heading_lines, line)
        line_num = line_num + 1
      end
      
      -- Get all headings from the main todo file
      local headings = {}
      local file = io.open(main_todo_file, "r")
      if not file then
        print("Cannot open main todo file: " .. main_todo_file)
        return
      end
      
      local line_number = 0
      for line in file:lines() do
        line_number = line_number + 1
        local heading_match = line:match("^(%*+)%s+(.+)")
        if heading_match then
          local stars, heading_text = line:match("^(%*+)%s+(.+)")
          table.insert(headings, {
            text = string.rep("  ", #stars - 1) .. heading_text,
            line_num = line_number,
            level = #stars,
            original_line = line
          })
        end
      end
      file:close()
      
      -- Show telescope picker
      pickers.new({}, {
        prompt_title = "Refile to heading",
        finder = finders.new_table {
          results = headings,
          entry_maker = function(entry)
            return {
              value = entry,
              display = entry.text,
              ordinal = entry.text,
            }
          end,
        },
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            
            if selection then
              -- Delete the current heading from current file
              vim.cmd(current_line_num .. "," .. (current_line_num + #heading_lines - 1) .. "delete")
              
              -- Read the main todo file
              local todo_lines = {}
              for line in io.lines(main_todo_file) do
                table.insert(todo_lines, line)
              end
              
              -- Find where to insert (after the selected heading and its content)
              local insert_line = selection.value.line_num
              local target_level = selection.value.level
              
              -- Find the end of the selected heading's content
              for i = selection.value.line_num + 1, #todo_lines do
                local line = todo_lines[i]
                local next_heading = line:match("^(%*+)%s")
                if next_heading and #next_heading <= target_level then
                  insert_line = i - 1
                  break
                end
                insert_line = i
              end
              
              -- Adjust the heading level of refiled content
              local level_diff = target_level - current_level + 1
              local adjusted_lines = {}
              for _, line in ipairs(heading_lines) do
                local stars = line:match("^(%*+)%s")
                if stars then
                  -- Adjust heading level
                  local new_stars = string.rep("*", #stars + level_diff)
                  line = line:gsub("^%*+", new_stars)
                end
                table.insert(adjusted_lines, line)
              end
              
              -- Insert the adjusted lines into todo_lines
              for i = #adjusted_lines, 1, -1 do
                table.insert(todo_lines, insert_line + 1, adjusted_lines[i])
              end
              
              -- Write back to the main todo file
              local file = io.open(main_todo_file, "w")
              if file then
                for _, line in ipairs(todo_lines) do
                  file:write(line .. "\n")
                end
                file:close()
                
                print("Refiled to: " .. selection.value.text)
                
                -- Save current file
                vim.cmd('write')
              else
                print("Error writing to main todo file")
              end
            end
          end)
          return true
        end,
      }):find()
    end

    -- Set up keymap for refiling
    vim.keymap.set('n', '<leader>msr', refile_to_main_todo, { 
      desc = "Refile heading to main todo",
      silent = true 
    })
  '';
}
