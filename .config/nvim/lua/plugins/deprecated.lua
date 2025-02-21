return {
  -- {
  --   "nvim-telescope/telescope-fzf-native.nvim",
  --   build = "make",
  --   config = function()
  --     require("telescope").load_extension("fzf")
  --   end,
  -- },
  --
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   keys = function()
  --     local builtin = require("telescope.builtin")
  --     local utils = require("telescope.utils")
  --
  --     local find_files = function(cwd)
  --       local c = {
  --         hidden = vim.g.telescope_find_files_hidden == true,
  --         no_ignore = vim.g.telescope_find_files_no_ignore == true,
  --       }
  --       if cwd ~= nil then
  --         c.cwd = cwd
  --         vim.g.telescope_find_files_cwd = cwd
  --       else
  --         vim.g.telescope_find_files_cwd = nil
  --       end
  --       builtin.find_files(c)
  --     end
  --     local live_grep = function(cwd)
  --       local c = {
  --       -- stylua: ignore
  --       additional_args = function(_)
  --         local args = {}
  --         if vim.g.telescope_live_grep_no_ignore then table.insert(args, "--no-ignore") end
  --         if vim.g.telescope_live_grep_hidden then table.insert(args, "--hidden") end
  --         return args
  --       end,
  --       }
  --       if cwd ~= nil then
  --         c.cwd = cwd
  --         vim.g.telescope_live_grep_cwd = cwd
  --       else
  --         vim.g.telescope_live_grep_cwd = nil
  --       end
  --       builtin.live_grep(c)
  --     end
  --
  --     local git_files = function()
  --       builtin.git_files({
  --         show_untracked = true,
  --         git_command = {
  --           "git",
  --           "ls-files",
  --           "--exclude-standard",
  --           "--modified",
  --         },
  --       })
  --     end
  --   -- stylua: ignore
  --   return {
  --     -- files
  --     { "<leader>fb", function() builtin.buffers({ sort_mru = true, sort_lastused = true }) end, desc = "Buffers" },
  --     { "<leader>fc", function() LazyVim.pick.config_files() end, desc = "Find Config File" },
  --     { "<leader>ff", find_files, desc = "Find Files (workspace)" },
  --     { "<leader>fF", function() find_files(utils.buffer_dir()) end, desc = "Find Files (bufferdir)" },
  --     { "<leader>fr", function() builtin.oldfiles({ cwd = vim.uv.cwd() }) end, desc = "Recent (workspace)" },
  --     { "<leader>fR", function() builtin.oldfiles() end, desc = "Recent" },
  --     -- git
  --     { "<leader>gf", git_files, desc = "changes" },
  --     { "<leader>gc", function() builtin.git_commits() end, desc = "commits" },
  --     { "<leader>gs", function() builtin.git_status() end, desc = "status" },
  --     -- search
  --     { '<leader>sa', function() builtin.registers() end, desc = "Registers" },
  --     { "<leader>sd", function() builtin.diagnostics({ bufnr=0 }) end, desc = "Document diagnostics" },
  --     { "<leader>sD", function() builtin.diagnostics() end, desc = "Workspace diagnostics" },
  --     { "<leader>sg", live_grep, desc = "Grep (workspace)" },
  --     { "<leader>sG", function() live_grep(utils.buffer_dir()) end, desc = "Grep (bufferdir)" },
  --     { "<leader>sb", function() builtin.current_buffer_fuzzy_find() end, desc = "Buffer search" },
  --     { "<leader>sm", function() builtin.marks() end, desc = "Jump to Mark" },
  --     { "<leader>sw", LazyVim.pick("grep_string", { word_match = "-w" }), desc = "Word (workspace)" },
  --     { "<leader>sw", LazyVim.pick("grep_string"), mode = "v", desc = "Selection (workspace)" },
  --     -- { "<leader>sW", LazyVim.pick("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (bufferdir)" },
  --     -- { "<leader>sW", LazyVim.pick("grep_string", { cwd = false }), mode = "v", desc = "Selection (bufferdir)" },
  --     -- stylua: ignore
  --     { "<leader>ss", function() builtin.lsp_document_symbols({ symbols = require("lazyvim.config").get_kind_filter() }) end, desc = "Goto Symbol" },
  --     -- stylua: ignore
  --     { "<leader>sS", function() builtin.lsp_dynamic_workspace_symbols({ symbols = lazyvimConfig.get_kind_filter() }) end, desc = "Goto Symbol (Workspace)" },
  --     -- helper
  --     { "<leader>ha", function() builtin.autocommands() end, desc = "Auto Commands" },
  --     { "<leader>hc", function() builtin.commands() end, desc = "Commands" },
  --     { "<leader>hC", function() builtin.colorscheme({ enable_preview = true }) end, desc = "Colorscheme" },
  --     { "<leader>hl", function() builtin.highlights() end, desc = "Highlight Groups" },
  --     { "<leader>hk", function() builtin.keymaps() end, desc = "Key Maps" },
  --     { "<leader>hm", function() builtin.man_pages() end, desc = "Man Pages" },
  --     { "<leader>ho", function() builtin.vim_options() end, desc = "Options" },
  --     { "<leader>.", function() builtin.resume() end, desc = "Recent Picker" },
  --
  --     { "<leader>,", function() builtin.buffers({ sort_mru = true, sort_lastused = true }) end, desc = "Buffers" },
  --     { "<leader>/", live_grep, desc = "Grep (workspace)" },
  --     { "<leader>m", git_files, desc = "Git changes" },
  --     { "<leader>;", function() builtin.command_history() end, desc = "Command History" },
  --     { "<leader>?", function() builtin.help_tags() end, desc = "Help Pages" },
  --     { "<leader><space>", find_files, desc = "Find Files (workspace)" },
  --
  --     { "<localleader>l", function() builtin.lsp_references() end, desc = "References" },
  --     { "<localleader>j", function() builtin.lsp_definitions() end, desc = "Definitions" },
  --     { "<localleader>k", function() builtin.lsp_type_definitions() end, desc = "Type Definitions" },
  --   }
  --   end,
  --   opts = function(_, opts)
  --     opts.defaults = opts.defaults or {}
  --     local defaults = {
  --       multi_icon = "✅",
  --       layout_config = {
  --         vertical = {
  --           width = 0.5,
  --           height = 0.65,
  --           prompt_position = "top",
  --           preview_cutoff = 40,
  --         },
  --       },
  --       layout_strategy = "vertical",
  --       mappings = { i = {}, n = {} },
  --       path_display = { path_display = { truncate = 3 } },
  --       file_ignore_patterns = {
  --         ".git",
  --         ".vscode",
  --         ".idea",
  --       },
  --       default_mappings = {},
  --     }
  --     opts.defaults = vim.tbl_extend("force", opts.defaults, defaults)
  --
  --     local remap_action = function(key, value, ...)
  --       local mode = { ... }
  --       for _, m in ipairs(mode) do
  --       -- stylua: ignore
  --       if m == "i" then opts.defaults.mappings.i[key] = value
  --       elseif m == "n" then opts.defaults.mappings.n[key] = value end
  --       end
  --     end
  --     local resolve_gstatus = function(status)
  --       return status == false or status == nil
  --     end
  --
  --     local builtin = require("telescope.builtin")
  --     local actions = require("telescope.actions")
  --     local action_state = require("telescope.actions.state")
  --
  --     local toggle_no_ignore = function(prompt_bufnr)
  --       local picker = action_state.get_current_picker(prompt_bufnr)
  --       if picker.prompt_title == "Find Files" then
  --         local enable = resolve_gstatus(vim.g.telescope_find_files_no_ignore)
  --         vim.g.telescope_find_files_no_ignore = enable
  --         local c = {
  --           no_ignore = enable,
  --           hidden = vim.g.telescope_find_files_hidden == true,
  --           cwd = vim.g.telescope_find_files_cwd or false,
  --           default_text = action_state.get_current_line(),
  --         }
  --         builtin.find_files(c)
  --       elseif picker.prompt_title == "Live Grep" then
  --         local enable = resolve_gstatus(vim.g.telescope_live_grep_no_ignore)
  --         vim.g.telescope_live_grep_no_ignore = enable
  --         local args = {}
  --       -- stylua: ignore
  --       if enable then table.insert(args, "--no-ignore") end
  --       -- stylua: ignore
  --       if vim.g.telescope_live_grep_hidden then table.insert(args, "--hidden") end
  --         local c = {
  --           additional_args = args,
  --           cwd = vim.g.telescope_live_grep_cwd or false,
  --           default_text = action_state.get_current_line(),
  --         }
  --         builtin.live_grep(c)
  --       end
  --     end
  --
  --     local toggle_hidden = function(prompt_bufnr)
  --       local picker = action_state.get_current_picker(prompt_bufnr)
  --       if picker.prompt_title == "Find Files" then
  --         local enable = resolve_gstatus(vim.g.telescope_find_files_hidden)
  --         vim.g.telescope_find_files_hidden = enable
  --         local c = {
  --           no_ignore = vim.g.telescope_find_files_no_ignore == true,
  --           hidden = enable,
  --           cwd = vim.g.telescope_find_files_cwd or false,
  --           default_text = action_state.get_current_line(),
  --         }
  --         builtin.find_files(c)
  --       elseif picker.prompt_title == "Live Grep" then
  --         local enable = resolve_gstatus(vim.g.telescope_live_grep_hidden)
  --         vim.g.telescope_live_grep_hidden = enable
  --         local args = {}
  --       -- stylua: ignore
  --       if enable then vim.list_extend(args, { "--hidden" }) end
  --       -- stylua: ignore
  --       if vim.g.telescope_live_grep_no_ignore then vim.list_extend(args, { "--no-ignore" }) end
  --         local c = {
  --           additional_args = args,
  --           cwd = vim.g.telescope_live_grep_cwd or false,
  --           default_text = action_state.get_current_line(),
  --         }
  --         builtin.live_grep(c)
  --       end
  --     end
  --
  --     -- remap_action("<c-n>", false, "i", "n")
  --     -- remap_action("<c-p>", false, "i", "n")
  --     -- remap_action("<c-u>", false, "i", "n")
  --     -- remap_action("<c-d>", false, "i", "n")
  --     -- remap_action("<c-f>", false, "i", "n")
  --     -- remap_action("<c-k>", false, "i", "n")
  --     -- remap_action("<m-f>", false, "i", "n")
  --     -- remap_action("<m-k>", false, "i", "n")
  --     -- remap_action("<m-q>", false, "i", "n")
  --     -- remap_action("<c-q>", false, "i", "n")
  --     -- remap_action("<c-b>", false, "i")
  --     -- remap_action("<a-h>", false, "i")
  --     -- remap_action("<a-i>", false, "i")
  --     -- remap_action("<a-t>", false, "i")
  --
  --     remap_action("<c-c>", actions.close, "i", "n")
  --     remap_action("<c-t>", actions.select_tab, "i", "n")
  --     remap_action("<cr>", actions.select_default, "i", "n")
  --     remap_action("<c-x>", actions.select_vertical, "i", "n")
  --     remap_action("<c-v>", actions.select_horizontal, "i", "n")
  --     remap_action("<up>", actions.move_selection_previous, "i", "n")
  --     remap_action("<down>", actions.move_selection_next, "i", "n")
  --     remap_action("<tab>", actions.toggle_selection + actions.move_selection_next, "i", "n")
  --     remap_action("<s-tab>", actions.toggle_selection + actions.move_selection_previous, "i", "n")
  --     remap_action("<s-left>", actions.preview_scrolling_left, "i", "n")
  --     remap_action("<s-right>", actions.preview_scrolling_right, "i", "n")
  --     remap_action("<s-up>", actions.preview_scrolling_up, "i", "n")
  --     remap_action("<s-down>", actions.preview_scrolling_down, "i", "n")
  --     remap_action("<c-left>", actions.cycle_history_prev, "i", "n")
  --     remap_action("<c-right>", actions.cycle_history_next, "i", "n")
  --     remap_action("<c-up>", actions.move_to_top, "i", "n")
  --     remap_action("<c-down>", actions.move_to_bottom, "i", "n")
  --     remap_action("<c-space>", actions.which_key, "i", "n")
  --     remap_action("<c-f>", toggle_no_ignore, "i", "n")
  --     remap_action("<c-d>", toggle_hidden, "i", "n")
  --     remap_action("q", actions.close, "n")
  --     remap_action("<esc>", actions.close, "n")
  --     remap_action("t", actions.select_tab, "n")
  --     remap_action("x", actions.select_vertical, "n")
  --     remap_action("v", actions.select_horizontal, "n")
  --     remap_action("h", actions.preview_scrolling_left, "n")
  --     remap_action("j", actions.preview_scrolling_down, "n")
  --     remap_action("k", actions.preview_scrolling_up, "n")
  --     remap_action("l", actions.preview_scrolling_right, "n")
  --
  --     if lazyvimUtil.has("flash.nvim") then
  --       local function flash(prompt_bufnr)
  --         require("flash").jump({
  --           pattern = "^",
  --           label = { after = { 0, 0 } },
  --           search = {
  --             mode = "search",
  --             exclude = {
  --               function(win)
  --                 return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
  --               end,
  --             },
  --           },
  --           action = function(match)
  --             local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
  --             picker:set_selection(match.pos[1] - 1)
  --           end,
  --         })
  --       end
  --       remap_action("<c-s>", flash, "i")
  --       remap_action("s", flash, "n")
  --     end
  --
  --     opts.pickers = opts.pickers or {}
  --     local dropdown_pickers = {
  --       -- "buffers", "live_grep", "find_files", "oldfiles", "git_files", "git_commits", "git_status",
  --       -- "current_buffer_fuzzy_find", "diagnostics", "grep_string", "lsp_document_symbols",
  --       -- "lsp_dynamic_workspace_symbols", "lsp_references",
  --       "help_tags",
  --       "command_history",
  --       "registers",
  --       "autocommands",
  --       "commands",
  --       "highlights",
  --       "keymaps",
  --       "colorscheme",
  --       "vim_options",
  --     }
  --     for _, value in pairs(dropdown_pickers) do
  --       opts.pickers[value] = { theme = "dropdown" }
  --     end
  --
  --     local cursor_pickers = { "lsp_definitions", "lsp_type_definitions" }
  --     for _, value in pairs(cursor_pickers) do
  --       opts.pickers[value] = { theme = "cursor" }
  --     end
  --     -- pickers.live_grep.additional_args = { "--hidden" }
  --   end,
  --
  --   config = function(_, opts)
  --     require("telescope").setup(opts)
  --     require("which-key").add({
  --       { "<leader>h", group = "helper" },
  --     })
  --   end,
  -- },
  --
  -- {
  --   -- read only repository
  --   "stevearc/dressing.nvim",
  --   event = "VeryLazy",
  --   config = true,
  --   opts = {
  --     input = {
  --       enabled = function()
  --         return vim.bo.filetype == "NvimTree"
  --       end,
  --     },
  --     select = {
  --       enabled = function()
  --         return vim.bo.filetype == "NvimTree"
  --       end,
  --     },
  --   },
  -- },
}
