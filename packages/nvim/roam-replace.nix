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
           vim.keymap.set('n', '<leader>ni', insert_note_link, { 
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
         vim.keymap.set('n', '<leader>nf', search_and_open_org_file, { 
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

  '';

}
