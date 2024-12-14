local lazyvimUtil = require("lazyvim.util")
local lazyvimConfig = require("lazyvim.config")

return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    config = function()
      local tree = require("nvim-tree")

      local function my_on_attach(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        -- api.config.mappings.default_on_attach(bufnr)

        local function add_key(mode, new, func, desc)
          vim.keymap.set(mode, new, func, opts(desc))
        end

        -- local function del_key(mode, old)
        --   vim.keymap.del(mode, old, { buffer = bufnr })
        -- end
        --
        -- local function replace_key(mode, old, new, func, desc)
        --   del_key(mode, old)
        --   add_key(mode, new, func, desc)
        -- end

        -- custom mappings
        add_key("n", "?", api.tree.toggle_help, "Show helps")
        add_key("n", "<s-left>", api.tree.change_root_to_parent, "Up")
        add_key("n", "<s-right>", api.tree.change_root_to_node, "Cd")
        add_key("n", "gm", api.tree.toggle_git_clean_filter, "Toggle git modified")
        add_key("n", "gi", api.tree.toggle_gitignore_filter, "Toggle git ignored")
        add_key("n", "e", api.tree.expand_all, "Expand all")
        add_key("n", "w", api.tree.collapse_all, "Collapse all")
        add_key("n", "q", api.tree.close, "Quit")
        add_key("n", "R", api.tree.reload, "Refresh")
        add_key("n", "S", api.tree.search_node, "Search")
        add_key("n", "H", api.tree.toggle_hidden_filter, "Toggle hidden")
        add_key("n", "B", api.tree.toggle_no_buffer_filter, "Toggle buffers")
        add_key("n", "U", api.tree.toggle_custom_filter, "Toggle custom filter")

        add_key("n", "<cr>", api.node.open.edit, "Open")
        add_key("n", "<tab>", api.node.open.preview, "Preview")
        add_key("n", "<right>", api.node.open.preview, "Preview")
        add_key("n", "<left>", api.node.navigate.parent, "Goto parent")
        add_key("n", "<bs>", api.node.navigate.parent_close, "Close Dir")
        add_key("n", "i", api.node.show_info_popup, "Show info")
        add_key("n", "o", api.node.open.replace_tree_buffer, "Open in place")
        add_key("n", "t", api.node.open.tab, "Open in new tab")
        add_key("n", "v", api.node.open.vertical, "Open vertically")
        add_key("n", "h", api.node.open.horizontal, "Open horizontally")
        add_key("n", "<", api.node.navigate.sibling.prev, "Prev sibling")
        add_key("n", ">", api.node.navigate.sibling.next, "Next sibling")
        add_key("n", "[c", api.node.navigate.git.prev, "Prev git")
        add_key("n", "]c", api.node.navigate.git.next, "Next git")
        add_key("n", "[e", api.node.navigate.diagnostics.prev, "Prev diagnostic")
        add_key("n", "]e", api.node.navigate.diagnostics.next, "Next diagnostic")
        add_key("n", "k", api.node.navigate.sibling.first, "First sibling")
        add_key("n", "j", api.node.navigate.sibling.last, "Last sibling")
        add_key("n", "O", api.node.run.system, "Open with vscode")
        add_key("n", ".", api.node.run.cmd, "Run command")

        add_key("n", "n", api.fs.create, "New")
        add_key("n", "c", api.fs.copy.node, "Copy")
        add_key("n", "gp", api.fs.copy.absolute_path, "Copy absolute path")
        add_key("n", "gr", api.fs.copy.relative_path, "Copy relative path")
        add_key("n", "gf", api.fs.copy.filename, "Copy file name")
        add_key("n", "r", api.fs.rename, "Rename")
        add_key("n", "b", api.fs.rename_basename, "Rename base")
        add_key("n", "x", api.fs.cut, "Cut")
        add_key("n", "p", api.fs.paste, "Paste")
        add_key("n", "D", api.fs.remove, "Delete")
        add_key("n", "T", api.fs.trash, "Trash")
        add_key("n", "X", api.fs.clear_clipboard, "Clear clipboard")

        add_key("n", "md", api.marks.bulk.delete, "Delete bookmarked")
        add_key("n", "mt", api.marks.bulk.trash, "Trash bookmarked")
        add_key("n", "mv", api.marks.bulk.move, "Move bookmarked")
        add_key("n", "mm", api.marks.toggle, "Toggle bookmark")

        add_key("n", "gl", api.git.reload, "Git reload")

        -- add_key("n", "F", api.live_filter.clear, "Clean Filter")
        -- add_key("n", "f", api.live_filter.start, "Filter")
      end
      tree.setup({
        on_attach = my_on_attach,
        view = {
          signcolumn = "no",
          width = {
            min = 20,
            max = 30,
            padding = 0,
          },
          float = {
            enable = false,
          },
        },
        filters = {
          dotfiles = false,
          custom = { "^.git$", "__pycache__" },
          exclude = { ".gitignore" },
        },
        renderer = {
          full_name = true,
          root_folder_label = ":~:s?$?",
          highlight_opened_files = "icon",
          highlight_modified = "name",
          indent_markers = {
            enable = true,
          },
        },
        update_focused_file = {
          enable = true,
        },
        system_open = {
          cmd = "code",
        },
        actions = {
          expand_all = {
            exclude = { ".git", ".vscode", ".idea", ".github", "__pycache__" },
          },
          open_file = {
            window_picker = {
              enable = true,
              -- picker = window_picker,
              chars = "QWERTYUIOPASDFGHJKLZXCVBNM1234567890",
              exclude = {
                filetype = {
                  "notify",
                  "NvimTree",
                  "neo-tree",
                  "neo-tree-popup",
                  "packer",
                  "qf",
                  "diff",
                  "fugitive",
                  "fugitiveblame",
                },
                buftype = {
                  "nofile",
                  "terminal",
                  "help",
                },
              },
            },
          },
        },
      })

      require("which-key").add({
        { "<leader>e", group = "File Explorer" },
        { "<leader>ef", "<cmd>NvimTreeFocus<cr>", desc = "Focus" },
        { "<leader>eg", "<cmd>lua require('nvim-tree.api').git.reload()<cr>", desc = "Git reload" },
        { "<leader>ee", "<cmd>NvimTreeToggle<cr>", desc = "Toggle" },
        { "<leader>ec", "<cmd>NvimTreeClipboard<cr>", desc = "Show clipboard" },
        { "<leader>ex", "<cmd>lua require('nvim-tree.api').fs.clear_clipboard()<cr>", desc = "Clear clipboard" },
        { "<localleader>e", "<leader>ef", desc = "Explorer focus", remap = true },
        { "<localleader><localleader>", "<leader>ee", desc = "Explorer toggle", remap = true },
      })
    end,
  },

  {
    "folke/flash.nvim",
    keys = function()
      -- stylua: ignore
      return {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" }
      }
    end,
  },

  {
    "phaazon/hop.nvim",
    event = "VeryLazy",
    -- stylua: ignore
    keys = {
      { "f", function() require("hop").hint_char1() end, remap = true },
      { "F", function() require("hop").hint_char2() end, remap = true },
      { "A", function() require("hop").hint_lines_skip_whitespace() end, remap = true },
      { "P", function() require("hop").hint_patterns() end, remap = true },
    },
    config = function()
      local positions = require("hop.hint").HintPosition
      require("hop").setup({ hint_position = positions.END })
    end,
  },

  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<localleader>x", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<localleader>X", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
    },
  },

  {
    "folke/todo-comments.nvim",
    -- stylua: ignore
    keys = {
      { "<localleader>t", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      { "<localleader>T", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
    },
    opts = {
      search = {
        pattern = [[#( )*(KEYWORDS)\b]],
      },
    },
  },

  {
    "sontungexpt/stcursorword",
    event = "VeryLazy",
    opts = {
      highlight = {
        underline = false,
        bg = "#44515e",
      },
    },
    config = true,
  },

  {
    "ibhagwan/fzf-lua",
    init = function()
      vim.ui.select = nil
    end,
    opts = {
      winopts = {
        height = 1,
        width = 0.35,
        row = 0.5,
        col = 1,
        border = false,
        layout = "horizontal",
        preview = {
          border = "noborder",
          wrap = "wrap",
          title = false,
          scrollbar = false,
          vertical = "down:70%",
        },
      },
      ui_select = nil,
    },
    keys = function()
      require("which-key").add({
        { "<leader>h", group = "helps" },
        { "<leader>ha", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
        { "<leader>hc", "<cmd>FzfLua commands<cr>", desc = "Commands" },
        { "<leader>hC", LazyVim.pick("colorschemes"), desc = "Colorscheme with Preview" },
        { "<leader>hh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
        { "<leader>hl", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
        { "<leader>hk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
        { "<leader>hm", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
      })

      return {
        { "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
        { "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },

        -- find
        { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
        { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
        { "<leader>ff", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
        { "<leader>fF", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
        { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
        { "<leader>fR", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
        -- git
        { "<leader>gf", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
        { "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Commits" },
        { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Status" },
        -- search
        { "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer" },
        { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
        { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
        { "<leader>sg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
        { "<leader>sG", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
        { "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
        { "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
        { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
        { "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
        { "<leader>sw", LazyVim.pick("grep_cword"), desc = "Word (Root Dir)" },
        { "<leader>sW", LazyVim.pick("grep_cword", { root = false }), desc = "Word (cwd)" },
        { "<leader>sw", LazyVim.pick("grep_visual"), mode = "v", desc = "Selection (Root Dir)" },
        { "<leader>sW", LazyVim.pick("grep_visual", { root = false }), mode = "v", desc = "Selection (cwd)" },
        { "<leader>o", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Goto Symbol" },
        { "<leader>O", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", desc = "Goto Symbol (Workspace)" },

        -- stylua: ignored
        { "<leader>.", "<cmd>FzfLua resume<cr>", desc = "Resume" },
        { "<leader>'", "<cmd>FzfLua registers<cr>", desc = "Registers" },
        { "<leader>,", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Switch Buffer" },
        { "<leader>/", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
        { "<leader>G", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
        { "<leader>;", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
        { "<leader><space>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      }
    end,
  },

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
}
