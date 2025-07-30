# Roam replace
{ lib, pkgs, ... }: {
  vim.luaConfigRC.extraPlugins = ''

                      ------------------------------Main Org Mode Configuration-----------
                      
                      ------------------------------Keymaps------------------------------
                      --Notes: Keymaps for specific custom functions are located within them.

                      -- Open Inbox 
                      vim.keymap.set('n', '<leader>=i', function()
                        vim.cmd('edit ' .. vim.fn.expand('~/Nextcloud/Dropbox/01-09_System/01-Emacs/01.02-OrgGtd/inbox.org'))
                      end, { desc = "Open Inbox" })

                      -- Open Todo Files 
                      vim.keymap.set('n', '<leader>=t', function()
                        vim.cmd('edit ' .. vim.fn.expand('~/Nextcloud/Dropbox/01-09_System/01-Emacs/01.02-OrgGtd/org-gtd-tasks.org'))
                      end, { desc = "Open Todo" })


                      -- Map <leader>nd to toggle TODO state in org files
                      vim.api.nvim_create_autocmd("FileType", {
                        pattern = "org",
                        callback = function()
                          vim.keymap.set('n', '<leader>nd', 'cit', { buffer = true, remap = true, desc = "Toggle TODO state" })
                        end,
                      })

                      -- Map <leader>nd to toggle TODO state in org files
                      vim.api.nvim_create_autocmd("FileType", {
                        pattern = "org",
                        callback = function()
                          vim.keymap.set('n', '<leader>nd', 'cit', { buffer = true, remap = true, desc = "Toggle TODO state" })
                        end,
                      })

                      -- Map <leader>mds to toggle TODO schedule 
                      --This is jus a remap of the actual keybind
                      vim.keymap.set('n', '<leader>mds', '<leader>ois', { buffer = true, remap = true, desc = "Set Scheduled Date" })

                      -- Map <leader>msa to archive 
                      --This is jus a remap of the actual keybind
                      vim.keymap.set('n', '<leader>msa', '<leader>o$', { buffer = true, remap = true, desc = "Archive" })

                      ----Clock in and out easily 
                      vim.api.nvim_create_autocmd("FileType", {
                        pattern = "org",
                        callback = function()
                          -- Set the keymaps
                          vim.keymap.set('n', '<leader>mci', function()
                            require('orgmode').action('clock.clock_in')
                          end, { buffer = true, desc = "Clock In" })
                          
                          vim.keymap.set('n', '<leader>mco', function()
                            require('orgmode').action('clock.clock_out')
                          end, { buffer = true, desc = "Clock Out" })
                        end,
                      })

                      ---- Meta + RETURN to add list items + Checkboxes
                      vim.keymap.set('n', '<M-CR>', '<Leader><CR>', { buffer = true, remap = true, desc = "Insert list/checkbox below" })

                      ---- SHIFT + RETURN to add list items + Checkboxes
                      vim.api.nvim_create_autocmd("FileType", {
                        pattern = "org",
                        callback = function()
                          vim.keymap.set('n', '<C-CR>', function()
                            require('orgmode').action('org_mappings.insert_todo_heading_respect_content')
                          end, { buffer = true, desc = "Insert TODO Heading" })
                        end,
                      })


                     ----Fix Hugo Files After Converting From Org----
                     ----Syntax for tilde is correct has to be escaped for the conversion and in this lua
                     vim.keymap.set('n', '<leader>Msc', function()
                       vim.cmd('%s/\\~\\~/+/g')
                       vim.cmd('%s/{.verbatim}//g')
                       vim.cmd('%s/{.underline}//g')
                     end, { desc = 'Run predefined find and replace' })

    ----------------------------Function to export to markdown hugo---------------------------------- 
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

                     ------------------------------Roam Replacement Functions----------------------

                     ------------------------------Function to create new .org file with timestamp--------------------
                     local function create_timestamped_org_file()
                       -- Get current timestamp in the format YYYYMMDDHHMMSS
                       local timestamp = os.date("%Y%m%d%H%M%S")
                       
                       -- Directory where you want to store the files (change this to your desired path)
                       local org_directory = vim.fn.expand("~/Nextcloud/Dropbox/40-49_Career/40-Career-ZK/") 
                       
                       -- Prompt user for the note name
                       local note_name = vim.fn.input("Note name: ")
                       
                       -- Check if user provided a name
                       if note_name == "" then
                         print("No note name provided. Aborting.")
                         return
                       end
                       
                       -- Create the filename with timestamp prefix
                       local filename = timestamp .. "-" .. note_name .. ".org"
                       local full_path = org_directory .. filename
                       
                       -- Create and open the new file
                       vim.cmd("edit " .. full_path)
                       
                       -- Optional: Add some initial content to the file
                       local lines = {
                         "#+TITLE: " .. note_name,
                         "#+DATE: " .. os.date("%Y-%m-%d %H:%M:%S"),
                         "",
                         "* " .. note_name,
                         "",
                         ""
                       }
                       
                       vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
                       -- Position cursor at the end
                       vim.api.nvim_win_set_cursor(0, {#lines, 0})
                     end

                     -- Set up the keymap for <leader>nn
                     vim.keymap.set('n', '<leader>nn', create_timestamped_org_file, { 
                       desc = "Create new org file",
                       silent = true 
                     })


                    ------------------------------ORG ROAM Replacement in raw lua----------------------

                     -- Required telescope modules
                     local telescope = require('telescope')
                     local pickers = require('telescope.pickers')
                     local finders = require('telescope.finders')
                     local conf = require('telescope.config').values
                     local actions = require('telescope.actions')
                     local action_state = require('telescope.actions.state')
                     local previewers = require('telescope.previewers')

                     -- Configuration

                     local org_directory = vim.fn.expand("~/Nextcloud/Dropbox/40-49_Career/40-Career-ZK/") -- Change this to match your notes directory

                     -- Function to create new .org file with timestamp
                     local function create_timestamped_org_file(note_name)
                       local timestamp = os.date("%Y%m%d%H%M%S")
                       local filename = timestamp .. "-" .. note_name .. ".org"
                       local full_path = org_directory .. filename
                       
                       -- Ensure the directory exists
                       vim.fn.mkdir(org_directory, "p")
                       
                       -- Create the file
                       local file = io.open(full_path, "w")
                       if file then
                         file:write("#+TITLE: " .. note_name .. "\n")
                         file:write("#+DATE: " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n")
                         file:write("\n")
                         file:write("* " .. note_name .. "\n")
                         file:write("\n")
                         file:close()
                       end
                       
                       return full_path, note_name
                     end

                     -- Function to search through org files and extract headings
                     local function search_org_content(search_term)
                       local results = {}
                       
                       -- Get all .org files in the directory
                       local org_files = vim.fn.glob(org_directory .. "*.org", false, true)
                       
                       for _, file_path in ipairs(org_files) do
                         local file = io.open(file_path, "r")
                         if file then
                           local filename = vim.fn.fnamemodify(file_path, ":t:r") -- Get filename without extension
                           local line_num = 0
                           
                           for line in file:lines() do
                             line_num = line_num + 1
                             
                             -- Check for org headings (* Header, ** Subheader, etc.)
                             local heading_match = line:match("^(%*+%s+.+)")
                             if heading_match then
                               local heading_text = heading_match:gsub("^%*+%s+", "") -- Remove asterisks and spaces
                               
                               -- Fuzzy search: check if search term appears in heading or filename
                               if string.lower(heading_text):find(string.lower(search_term), 1, true) or
                                  string.lower(filename):find(string.lower(search_term), 1, true) then
                                 table.insert(results, {
                                   display = filename .. " -> " .. heading_text,
                                   file_path = file_path,
                                   filename = filename,
                                   heading = heading_text,
                                   line_num = line_num
                                 })
                               end
                             end
                             
                             -- Also check file titles
                             local title_match = line:match("^#+TITLE:%s*(.+)")
                             if title_match then
                               if string.lower(title_match):find(string.lower(search_term), 1, true) or
                                  string.lower(filename):find(string.lower(search_term), 1, true) then
                                 table.insert(results, {
                                   display = filename .. " -> " .. title_match,
                                   file_path = file_path,
                                   filename = filename,
                                   heading = title_match,
                                   line_num = line_num,
                                   is_title = true
                                 })
                               end
                             end
                           end
                           file:close()
                         end
                       end
                       
                       return results
                     end

                     -- Function to get all org content for telescope live search
                     local function get_all_org_content()
                       local results = {}
                       
                       -- Get all .org files in the directory
                       local org_files = vim.fn.glob(org_directory .. "*.org", false, true)
                       
                       for _, file_path in ipairs(org_files) do
                         local file = io.open(file_path, "r")
                         if file then
                           local filename = vim.fn.fnamemodify(file_path, ":t:r") -- Get filename without extension
                           local line_num = 0
                           
                           for line in file:lines() do
                             line_num = line_num + 1
                             
                             -- Check for org headings (* Header, ** Subheader, etc.)
                             local heading_match = line:match("^(%*+%s+.+)")
                             if heading_match then
                               local heading_text = heading_match:gsub("^%*+%s+", "") -- Remove asterisks and spaces
                               
                               table.insert(results, {
                                 display = filename .. " -> " .. heading_text,
                                 file_path = file_path,
                                 filename = filename,
                                 heading = heading_text,
                                 line_num = line_num
                               })
                             end
                             
                             -- Also check file titles
                             local title_match = line:match("^#+TITLE:%s*(.+)")
                             if title_match then
                               table.insert(results, {
                                 display = filename .. " -> " .. title_match,
                                 file_path = file_path,
                                 filename = filename,
                                 heading = title_match,
                                 line_num = line_num,
                                 is_title = true
                               })
                             end
                           end
                           file:close()
                         end
                       end
                       
                       return results
                     end

                     ------------------------------ Function to insert org link at cursor position -----------------------
                     local function insert_org_link(file_path, heading, is_title)
                       local filename = vim.fn.fnamemodify(file_path, ":t:r")
                       local link
                       
                       if is_title then
                         link = "[[file:" .. filename .. ".org][" .. heading .. "]]"
                       else
                         -- Create link with heading anchor
                         local heading_anchor = heading:gsub("%s+", "-"):gsub("[^%w%-]", ""):lower()
                         link = "[[file:" .. filename .. ".org::" .. heading .. "][" .. heading .. "]]"
                       end
                       
                       -- Get current cursor position
                       local row, col = unpack(vim.api.nvim_win_get_cursor(0))
                       
                       -- Insert the link at cursor position
                       local current_line = vim.api.nvim_get_current_line()
                       local new_line = current_line:sub(1, col) .. link .. current_line:sub(col + 1)
                       vim.api.nvim_set_current_line(new_line)
                       
                       -- Move cursor to end of inserted link
                       vim.api.nvim_win_set_cursor(0, {row, col + #link})
                     end

                     -- Main function for inserting note links
                     local function insert_note_link()
                       -- Get all content first
                       local all_results = get_all_org_content()
                       
                       -- Show telescope picker with all results
                       pickers.new({}, {
                         prompt_title = "Select Note/Heading (create new with <C-n>/cancel <C-c>)",
                         finder = finders.new_table {
                           results = all_results,
                           entry_maker = function(entry)
                             return {
                               value = entry,
                               display = entry.display,
                               ordinal = entry.display,
                             }
                           end,
                         },
                         sorter = conf.generic_sorter({}),
                         previewer = previewers.new_buffer_previewer({
                           title = "Preview",
                           define_preview = function(self, entry, status)
                             local lines = {}
                             local file = io.open(entry.value.file_path, "r")
                             if file then
                               for line in file:lines() do
                                 table.insert(lines, line)
                               end
                               file:close()
                             end
                             
                             vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
                             vim.api.nvim_buf_set_option(self.state.bufnr, 'filetype', 'org')
                             
                             -- Highlight the matching line
                             if entry.value.line_num then
                               vim.api.nvim_buf_add_highlight(self.state.bufnr, -1, 'TelescopeSelection', 
                                                            entry.value.line_num - 1, 0, -1)
                             end
                           end,
                         }),
                         attach_mappings = function(prompt_bufnr, map)
                           -- Default action: select and insert link
                           actions.select_default:replace(function()
                             local selection = action_state.get_selected_entry()
                             actions.close(prompt_bufnr)
                             
                             if selection then
                               insert_org_link(selection.value.file_path, selection.value.heading, selection.value.is_title)
                               print("Inserted link to: " .. selection.value.heading)
                             end
                           end)


                           -- Function to open the newly created file in a buffer
                           local function open_file_in_buffer(file_path)
                             -- Save current buffer if modified
                             if vim.bo.modified then
                               vim.cmd('write')
                             end
                                                                    
                                   -- Open the file in current window
                                   vim.cmd('edit ' .. vim.fn.fnameescape(file_path))
                                 end

                                 
                                 -- Add mapping for creating new note (Ctrl+n)
                                 map('i', '<C-n>', function()
                                   local current_picker = action_state.get_current_picker(prompt_bufnr)
                                   local prompt = current_picker:_get_prompt()
                                   actions.close(prompt_bufnr)
                                   
                                   if prompt and prompt ~= "" then
                                     print("Creating new note: " .. prompt)
                                     local file_path, note_name = create_timestamped_org_file(prompt)
                                     insert_org_link(file_path, note_name, true)
                                     print("Created new note and inserted link: " .. note_name)

                                     -- Open the newly created file
                                     open_file_in_buffer(file_path)

                                   else
                                     print("No note name provided.")
                                   end
                                 end)
                                 
                                 -- Optional: Add mapping for creating new note with custom name (Ctrl+c)
                                 map('i', '<C-c>', function()
                                   actions.close(prompt_bufnr)
                                   local note_name = vim.fn.input("New note name: ")
                                   
                                   if note_name and note_name ~= "" then
                                     local file_path, created_name = create_timestamped_org_file(note_name)
                                     insert_org_link(file_path, created_name, true)
                                     print("Created new note and inserted link: " .. created_name)

                                     -- Open the newly created file
                                         open_file_in_buffer(file_path)


                                   else
                                     print("No note name provided.")
                                   end
                                 end)
                                 
                                 return true
                               end,
                             }):find()
                           end

                           -- Set up the keymap for <leader>ni
                           vim.keymap.set('n', '<leader>nri', insert_note_link, { 
                             desc = "Insert note link (search or create)",
                             silent = true 
                           })

                         ------------------------------Function for fuzzy file search and open ---------------------
                         local function search_and_open_org_file()
                           -- Get all .org files in the directory
                           local org_files = vim.fn.glob(org_directory .. "*.org", false, true)
                           local file_entries = {}
                           
                           -- Create entries for telescope
                           for _, file_path in ipairs(org_files) do
                             local filename = vim.fn.fnamemodify(file_path, ":t:r") -- filename without extension
                             local title = ""
                             
                             -- Try to get the title from the file
                             local file = io.open(file_path, "r")
                             if file then
                               for line in file:lines() do
                                 local title_match = line:match("^#+TITLE:%s*(.+)")
                                 if title_match then
                                   title = title_match
                                   break
                                 end
                               end
                               file:close()
                             end
                             
                             table.insert(file_entries, {
                               display = title ~= "" and (filename .. " - " .. title) or filename,
                               file_path = file_path,
                               filename = filename,
                               title = title
                             })
                           end
                           
                           -- Show telescope picker
                           pickers.new({}, {
                             prompt_title = "Search and Open Org File",
                             finder = finders.new_table {
                               results = file_entries,
                               entry_maker = function(entry)
                                 return {
                                   value = entry,
                                   display = entry.display,
                                   ordinal = entry.display .. " " .. entry.filename, -- search both filename and title
                                 }
                               end,
                             },
                             sorter = conf.generic_sorter({}),
                             previewer = previewers.new_buffer_previewer({
                               title = "Preview",
                               define_preview = function(self, entry, status)
                                 local lines = {}
                                 local file = io.open(entry.value.file_path, "r")
                                 if file then
                                   for line in file:lines() do
                                     table.insert(lines, line)
                                   end
                                   file:close()
                                 end
                                 
                                 vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
                                 vim.api.nvim_buf_set_option(self.state.bufnr, 'filetype', 'org')
                               end,
                             }),
                             attach_mappings = function(prompt_bufnr, map)
                               actions.select_default:replace(function()
                                 local selection = action_state.get_selected_entry()
                                 actions.close(prompt_bufnr)
                                 
                                 if selection then
                                   -- Save current buffer if modified
                                   if vim.bo.modified then
                                     vim.cmd('write')
                                   end
                                   
                                   -- Open the selected file
                                   vim.cmd('edit ' .. vim.fn.fnameescape(selection.value.file_path))
                                   print("Opened: " .. selection.value.display)
                                 end
                               end)
                               return true
                             end,
                           }):find()
                         end

                         -- Set up the keymap for <leader>nf
                         vim.keymap.set('n', '<leader>nrf', search_and_open_org_file, { 
                           desc = "Find and open org file",
                           silent = true 
                         })

                     ------------------------------Function to follow org links------------------------------
                     local function follow_org_link()
                       -- Get the current line
                       local line = vim.api.nvim_get_current_line()
                       local col = vim.fn.col('.')
                       
                       -- Find the link under cursor
                       local file_part
                       
                       -- Pattern for link with heading: [[file:filename.org::*Heading][Link text]]
                       local link_start = line:find("%[%[file:", 1, true)
                       while link_start do
                         local link_end = line:find("%]%]", link_start, true)
                         if link_end and link_start <= col and col <= link_end + 2 then
                           -- Extract the link content
                           local link_content = line:sub(link_start + 7, link_end - 1) -- Skip "[[file:"
                           
                           -- Check if it has a heading
                           local heading_separator = link_content:find("::", 1, true)
                           if heading_separator then
                             file_part = link_content:sub(1, heading_separator - 1)
                           else
                             -- Simple file link
                             local bracket_pos = link_content:find("%]%[", 1, true)
                             if bracket_pos then
                               file_part = link_content:sub(1, bracket_pos - 1)
                             else
                               file_part = link_content
                             end
                           end
                           break
                         end
                         link_start = line:find("%[%[file:", link_end, true)
                       end
                       
                       if not file_part then
                         print("No org link found under cursor")
                         return
                       end
                       
                       -- Construct full file path
                       local file_path
                       if file_part:match("^/") or file_part:match("^~/") then
                         -- Absolute path
                         file_path = vim.fn.expand(file_part)
                       else
                         -- Relative path - assume it's in the same directory
                         file_path = org_directory .. file_part
                       end
                       
                       -- Check if file exists
                       if vim.fn.filereadable(file_path) == 0 then
                         print("File not found: " .. file_path)
                         return
                       end
                       
                       -- Open the file
                       vim.cmd('edit ' .. vim.fn.fnameescape(file_path))
                       print("Opened: " .. file_part)
                     end

                     -- Override gf to use our custom function when on an org link
                     vim.keymap.set('n', 'gf', function()
                       local line = vim.api.nvim_get_current_line()
                       local col = vim.fn.col('.')
                       
                       -- Check if cursor is anywhere within an org link structure
                       local is_on_org_link = false
                       
                       -- First, check if we're inside a [[file:...]] structure
                       local pos = 1
                       while true do
                         local start_pos = line:find("%[%[", pos, true)  -- Changed to look for [[ instead of [[file:
                         if not start_pos then break end
                         
                         -- Check if this is a file link
                         local file_check = line:sub(start_pos + 2, start_pos + 6)
                         if file_check == "file:" then
                           -- For links with display text, find the final ]]
                           local temp_pos = start_pos
                           local end_pos = nil
                           local nesting = 0
                           
                           -- Look for the matching ]] that closes this link
                           while temp_pos <= #line do
                             local next_open = line:find("%[%[", temp_pos + 1, true)
                             local next_close = line:find("%]%]", temp_pos + 1, true)
                             
                             if next_close and (not next_open or next_close < next_open) then
                               if nesting == 0 then
                                 end_pos = next_close
                                 break
                               else
                                 nesting = nesting - 1
                                 temp_pos = next_close + 2
                               end
                             elseif next_open then
                               nesting = nesting + 1
                               temp_pos = next_open + 2
                             else
                               break
                             end
                           end
                           
                           if end_pos and start_pos <= col and col <= end_pos + 1 then
                             is_on_org_link = true
                             break
                           end
                         end
                         
                         pos = start_pos + 1
                       end
                       
                       if is_on_org_link then
                         follow_org_link()
                       else
                         -- Fall back to default gf behavior
                         vim.cmd('normal! gf')
                       end
                     end, { desc = "Go to file under cursor (with org link support)", silent = true })


                -------------------------------------------------EASY REFILE-------------------------
                -- Function to refile current heading to a location in your main todo file
                local function refile_to_main_todo()
                  -- Path to your main todo file
                  local main_todo_file = vim.fn.expand("~/Nextcloud/Dropbox/01-09_System/01-Emacs/01.02-OrgGtd/org-gtd-tasks.org") -- Update this path
                  
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
            -----------------------------------------INSERT IMAGES EASILY------------------------------
            local function insert_screenshot_link()
              local screenshots_dir = "/home/martin/Nextcloud/Dropbox/screenshots/"
              
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
