local lsp_util = require("vqcuong.utils.lsp")

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

      -- local function window_picker()
      -- 	local status, wp = pcall(require, "window-picker")
      -- 	if not status then
      -- 		print("You'll need to install window-picker before use this command")
      -- 		return "default"
      -- 	else
      -- 		local picked_window_id = require("window-picker").pick_window({ hint = "floating-big-letter" })
      -- 		if picked_window_id then
      -- 			vim.api.nvim_set_current_win(picked_window_id)
      -- 			return picked_window_id
      -- 		end
      -- 		return "default"
      -- 	end
      -- end

      local function my_on_attach(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return { desc = "NvimTree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        -- api.config.mappings.default_on_attach(bufnr)

        local function add_key(mode, new, func, desc)
          vim.keymap.set(mode, new, func, opts(desc))
        end

        local function del_key(mode, old)
          vim.keymap.del(mode, old, { buffer = bufnr })
        end

        local function replace_key(mode, old, new, func, desc)
          del_key(mode, old)
          add_key(mode, new, func, desc)
        end
        -- custom mappings
        add_key("n", "?", api.tree.toggle_help, "Help")
        add_key("n", "<S-Left>", api.tree.change_root_to_parent, "Up")
        add_key("n", "<S-Right>", api.tree.change_root_to_node, "CD")
        add_key("n", "gc", api.tree.toggle_git_clean_filter, "Git Clean Filter")
        add_key("n", "gi", api.tree.toggle_gitignore_filter, "Git Ignore Filter")
        add_key("n", "E", api.tree.expand_all, "Expand All")
        add_key("n", "W", api.tree.collapse_all, "Collapse All")
        add_key("n", "q", api.tree.close, "Close Tree")
        add_key("n", "R", api.tree.reload, "Refresh Tree")
        add_key("n", "S", api.tree.search_node, "Search")
        add_key("n", "D", api.tree.toggle_hidden_filter, "Filter Dotfiles")
        add_key("n", "B", api.tree.toggle_no_buffer_filter, "Filter No Buffer")
        add_key("n", "U", api.tree.toggle_custom_filter, "Filter Hidden")

        add_key("n", "<CR>", api.node.open.edit, "Open")
        add_key("n", "<Tab>", api.node.open.preview, "Preview")
        add_key("n", "<Right>", api.node.open.preview, "Preview")
        add_key("n", "<Left>", api.node.navigate.parent, "Goto Parent")
        add_key("n", "I", api.node.show_info_popup, "Get Info")
        add_key("n", "<C-e>", api.node.open.replace_tree_buffer, "Open In Place")
        add_key("n", "<C-t>", api.node.open.tab, "Open In New Tab")
        add_key("n", "V", api.node.open.vertical, "Open - Split vertically")
        add_key("n", "H", api.node.open.horizontal, "Open - Split horizontally")
        add_key("n", "<", api.node.navigate.sibling.prev, "Previous Sibling")
        add_key("n", ">", api.node.navigate.sibling.next, "Next Sibling")
        add_key("n", "[c", api.node.navigate.git.prev, "Previous Git")
        add_key("n", "]c", api.node.navigate.git.next, "Next Git")
        add_key("n", "[e", api.node.navigate.diagnostics.prev, "Previous Diagnostic")
        add_key("n", "]e", api.node.navigate.diagnostics.next, "Next Diagnostic")
        add_key("n", "K", api.node.navigate.sibling.first, "First Sibling")
        add_key("n", "J", api.node.navigate.sibling.last, "Last Sibling")
        add_key("n", "P", api.node.navigate.parent, "Parent Directory")
        add_key("n", "<BS>", api.node.navigate.parent_close, "Close Directory")
        add_key("n", "C", api.node.run.system, "Open In VSCode")
        add_key("n", ".", api.node.run.cmd, "Run Command")

        add_key("n", "nn", api.fs.create, "New")
        add_key("n", "cc", api.fs.copy.node, "Copy")
        add_key("n", "cp", api.fs.copy.absolute_path, "Copy Absolute Path")
        add_key("n", "cr", api.fs.copy.relative_path, "Copy Relative Path")
        add_key("n", "cn", api.fs.copy.filename, "Copy File Name")
        add_key("n", "rr", api.fs.rename, "Rename")
        add_key("n", "rb", api.fs.rename_basename, "Rename")
        add_key("n", "xx", api.fs.cut, "Cut")
        add_key("n", "pp", api.fs.paste, "Paste")
        add_key("n", "dd", api.fs.remove, "Delete")
        add_key("n", "dt", api.fs.trash, "Trash")

        add_key("n", "bd", api.marks.bulk.delete, "Delete Bookmarked")
        add_key("n", "bt", api.marks.bulk.trash, "Trash Bookmarked")
        add_key("n", "bv", api.marks.bulk.move, "Move Bookmarked")
        add_key("n", "bb", api.marks.toggle, "Toggle Bookmark")

        -- add_key("n", "F", api.live_filter.clear, "Clean Filter")
        -- add_key("n", "f", api.live_filter.start, "Filter")
      end
      tree.setup({
        on_attach = my_on_attach,
        view = {
          width = {
            min = 20,
            max = 30,
            padding = 0,
          },
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
            exclude = { ".git", ".vscode", ".idea" },
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
      local function opts(desc)
        return { desc = "NvimTree: " .. desc, noremap = true, silent = true, nowait = true }
      end

      vim.keymap.set("n", "mg", "<CMD>lua require('nvim-tree.api').git.reload()<CR>", opts("Git Reload"))
      vim.keymap.set("n", "mm", "<CMD>NvimTreeFocus<CR>", opts("Focus Tree"))
      vim.keymap.set("n", "mn", "<CMD>NvimTreeToggle<CR>", opts("Toggle Tree"))
      vim.keymap.set("n", "mb", "<CMD>NvimTreeClipboard<CR>", opts("Show Clipboard"))
      vim.keymap.set("n", "mx", "<CMD>lua require('nvim-tree.api').fs.clear_clipboard()<CR>", opts("Clear Clipboard"))
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    enabled = false,
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.fn.stdpath("config") })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
      {
        "<leader>ge",
        function()
          require("neo-tree.command").execute({ source = "git_status", toggle = true })
        end,
        desc = "Git explorer",
      },
      {
        "<leader>be",
        function()
          require("neo-tree.command").execute({ source = "buffers", toggle = true })
        end,
        desc = "Buffer explorer",
      },
    },

    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      if vim.fn.argc(-1) == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["<space>"] = "none",
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
      },
    },
    config = function(_, opts)
      local function on_move(data)
        lsp_util.on_rename(data.source, data.destination)
      end

      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
      require("neo-tree").setup(opts)
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then
            require("neo-tree.sources.git_status").refresh()
          end
        end,
      })
    end,
  },
  -- search/replace in multiple files
  {
    "nvim-pack/nvim-spectre",
    build = false,
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "replace in files (spectre)" },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    opts = function()
      local actions = require("telescope.actions")
      return {
        defaults = {
          mappings = {
            n = {
              ["q"] = actions.close,
            },
          },
          winblend = 0,
          prompt_prefix = " ",
          selection_caret = "> ",
          multi_icon = "",
          initial_mode = "normal",
          border = false,
          path_display = {
            "smart",
          },
          file_ignore_patterns = {
            "^.git/",
          },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
          },
        },
      }
    end,
    keys = {
      -- find
      {
        "<leader>/",
        function()
          require("telescope.builtin").live_grep(require("telescope.themes").get_dropdown({
            hidden = true,
            additional_args = { "--hidden" },
            max_results = 100,
            initial_mode = "insert",
          }))
        end,
        desc = "live grep",
      },
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({
            border = false,
            follow = true,
            no_ignore = true,
            hidden = true,
            initial_mode = "insert",
          }))
        end,
        desc = "find files",
      },
      {
        "<leader>fF",
        function()
          require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({
            border = false,
            follow = true,
            no_ignore = true,
            hidden = true,
            cwd = false,
            initial_mode = "insert",
          }))
        end,
        desc = "find files",
      },
      {
        "<leader>fr",
        function()
          require("telescope.builtin").oldfiles(require("telescope.themes").get_dropdown({
            border = false,
            initial_mode = "insert",
          }))
        end,
        desc = "recent files",
      },
      {
        "<leader>fR",
        function()
          require("telescope.builtin").oldfiles(require("telescope.themes").get_dropdown({
            border = false,
            cwd_only = true,
            initial_mode = "insert",
          }))
        end,
        desc = "recent files (cwd)",
      },
      {
        "<leader>fb",
        function()
          require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({
            border = false,
            ignore_current_buffer = false,
            sort_lastused = true,
            sort_mru = true,
          }))
        end,
        desc = "buffers",
      },

      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "commits" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "status" },

      -- search
      { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "registers" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "buffer" },
      { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "commands" },
      { "<leader>sC", "<cmd>Telescope command_history<cr>", desc = "command History" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "document diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "workspace diagnostics" },
      {
        "<leader>sg",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "grep (root dir)",
      },
      {
        "<leader>sG",
        function()
          require("telescope.builtin").live_grep({ cwd = false })
        end,
        desc = "grep (cwd)",
      },

      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "helps" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "highlight groups" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "keymaps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "man pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "jump to mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "vim options" },
      {
        "<leader>uc",
        function()
          require("telescope.builtin").colorscheme(require("telescope.themes").get_dropdown({
            border = false,
            enable_preview = true,
            initial_mode = "insert",
          }))
        end,
        desc = "colorscheme",
      },
      {
        "<leader>d",
        function()
          require("telescope.builtin").diagnostics(require("telescope.themes").get_cursor({
            border = false,
            bufnr = 0,
            layout_config = {
              width = 20,
              height = 10,
            },
          }))
        end,
        desc = "document diagnostics",
      },
      {
        "<leader>D",
        function()
          require("telescope.builtin").diagnostics(require("telescope.themes").get_cursor({
            border = false,
            layout_config = {
              width = 20,
              height = 10,
            },
          }))
        end,
        desc = "workspace diagnostics",
      },
      {
        "<leader>S",
        function()
          require("telescope.builtin").spell_suggest(require("telescope.themes").get_cursor({
            border = false,
            layout_config = {
              width = 20,
              height = 10,
            },
          }))
        end,
        desc = "spell suggest",
      },
      {
        "<leader>lr",
        function()
          require("telescope.builtin").lsp_references(require("telescope.themes").get_cursor({
            border = false,
            layout_config = {
              width = 20,
              height = 10,
            },
          }))
        end,
        desc = "lsp references",
      },

      {
        "<leader>ld",
        function()
          require("telescope.builtin").lsp_definitions(require("telescope.themes").get_cursor({
            border = false,
            layout_config = {
              width = 20,
              height = 10,
            },
          }))
        end,
        desc = "lsp definitions",
      },
      {
        "<leader>lt",
        function()
          require("telescope.builtin").lsp_type_definitions(require("telescope.themes").get_cursor({
            border = false,
            layout_config = {
              width = 20,
              height = 10,
            },
          }))
        end,
        desc = "lsp type definitions",
      },
      {
        "<leader>li",
        function()
          require("telescope.builtin").lsp_implementations(require("telescope.themes").get_cursor({
            border = false,
            layout_config = {
              width = 20,
              height = 10,
            },
          }))
        end,
        desc = "lsp implementations",
      },
    },
    config = function()
      require("telescope").load_extension("fzf")
    end,
    opts = function()
      local actions = require("telescope.actions")

      local open_with_trouble = function(...)
        return require("trouble.providers.telescope").open_with_trouble(...)
      end
      local open_selected_with_trouble = function(...)
        return require("trouble.providers.telescope").open_selected_with_trouble(...)
      end
      local find_files_no_ignore = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        require("telescope.builtin").find_files({ no_ignore = true, default_text = line })
      end
      local find_files_with_hidden = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        require("telescope.builtin").find_files({ hidden = true, default_text = line })
      end

      return {
        defaults = {
          winblend = 0,
          border = false,
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "smart" },
          file_ignore_patterns = { "^.git/" },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
          },
          -- open files in the first window that is an actual file.
          -- use the current window if no other window is available.
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then
                return win
              end
            end
            return 0
          end,
          mappings = {
            i = {
              ["<c-t>"] = open_with_trouble,
              ["<a-t>"] = open_selected_with_trouble,
              ["<a-i>"] = find_files_no_ignore,
              ["<a-h>"] = find_files_with_hidden,
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
              ["<C-f>"] = actions.preview_scrolling_down,
              ["<C-b>"] = actions.preview_scrolling_up,
            },
            n = {
              ["q"] = actions.close,
            },
          },
        },
      }
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash Jump",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
    config = function()
      require("flash").setup({
        modes = {
          char = {
            keys = { "s", "S" },
          },
        },
      })
    end,
  },
  {
    "phaazon/hop.nvim",
    event = "VeryLazy",
    -- stylua: ignore
    keys = {
      { "f", function() require("hop").hint_char1() end, remap = true },
      { "F", function() require("hop").hint_char2() end, remap = true },
      { "L", function() require("hop").hint_lines_skip_whitespace() end, remap = true },
      { "P", function() require("hop").hint_patterns() end, remap = true },
    },
    config = function()
      local positions = require("hop.hint").HintPosition
      require("hop").setup({ hint_position = positions.END })
    end,
  },
  {
    "RRethy/vim-illuminate",
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },

  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
  },

  -- Finds and lists all of the TODO, HACK, BUG, etc comment
  -- in your project and loads them into a browsable list.
  {
    "folke/todo-comments.nvim",
    lazy = true,
    cmd = { "TodoTrouble", "TodoTelescope" },
    config = true,
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },

  -- {
  -- 	"gelguy/wilder.nvim",
  -- 	config = function()
  -- 		local wilder = require("wilder")
  -- 		local gradient = {
  -- 			"#f4468f",
  -- 			"#fd4a85",
  -- 			"#ff507a",
  -- 			"#ff566f",
  -- 			"#ff5e63",
  -- 			"#ff6658",
  -- 			"#ff704e",
  -- 			"#ff7a45",
  -- 			"#ff843d",
  -- 			"#ff9036",
  -- 			"#f89b31",
  -- 			"#efa72f",
  -- 			"#e6b32e",
  -- 			"#dcbe30",
  -- 			"#d2c934",
  -- 			"#c8d43a",
  -- 			"#bfde43",
  -- 			"#b6e84e",
  -- 			"#aff05b",
  -- 		}
  --
  -- 		for i, fg in ipairs(gradient) do
  -- 			gradient[i] =
  -- 				wilder.make_hl("WilderGradient" .. i, "Pmenu", { { a = 1 }, { a = 1 }, { foreground = fg } })
  -- 		end
  --
  -- 		wilder.setup({
  -- 			modes = { ":", "/", "?" },
  -- 			next_key = "<Tab>",
  -- 			previous_key = "<S-Tab>",
  -- 		})
  --
  -- 		wilder.set_option("pipeline", {
  -- 			wilder.branch(
  -- 				wilder.python_file_finder_pipeline({
  -- 					file_command = { "fd", "-tf", "-H", "-E", ".git" },
  -- 					dir_command = { "fd", "fi", "--type", "d", "-H", "--max-depth", "5" },
  -- 					filters = { "fuzzy_filter", "difflib_sorter" },
  -- 				}),
  -- 				wilder.substitute_pipeline({
  -- 					pipeline = wilder.python_search_pipeline({
  -- 						skip_cmdtype_check = 1,
  -- 						pattern = wilder.python_fuzzy_pattern({
  -- 							start_at_boundary = 0,
  -- 						}),
  -- 					}),
  -- 				}),
  -- 				wilder.cmdline_pipeline({
  -- 					language = "python",
  -- 					fuzzy = 1,
  -- 				}),
  -- 				{
  -- 					wilder.check(function(ctx, x)
  -- 						return x == ""
  -- 					end),
  -- 					wilder.history(),
  -- 				},
  -- 				wilder.python_search_pipeline({
  -- 					pattern = wilder.python_fuzzy_pattern({
  -- 						start_at_boundary = 0,
  -- 					}),
  -- 				})
  -- 			),
  -- 		})
  -- 		wilder.set_option(
  -- 			"renderer",
  -- 			-- wilder.popupmenu_renderer(wilder.popupmenu_palette_theme({
  -- 			-- 	highlights = {
  -- 			-- 		gradient = gradient,
  -- 			-- 	},
  -- 			-- 	border = "rounded",
  -- 			-- 	max_height = "65%",
  -- 			-- 	min_height = "20%",
  -- 			-- 	max_width = "50%",
  -- 			-- 	min_width = "20%",
  -- 			-- 	prompt_position = "top",
  -- 			-- 	highlighter = wilder.highlighter_with_gradient({
  -- 			-- 		wilder.basic_highlighter(),
  -- 			-- 	}),
  -- 			-- 	left = { " ", wilder.popupmenu_devicons() },
  -- 			-- 	pumblend = 10,
  -- 			-- }))
  -- 			wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
  -- 				highlights = {
  -- 					gradient = gradient,
  -- 				},
  -- 				border = "rounded",
  -- 				empty_message = wilder.popupmenu_empty_message_with_spinner(),
  -- 				highlighter = wilder.highlighter_with_gradient({
  -- 					wilder.basic_highlighter(),
  -- 				}),
  -- 				left = {
  -- 					" ",
  -- 					wilder.popupmenu_devicons(),
  -- 					wilder.popupmenu_buffer_flags({
  -- 						flags = " a + ",
  -- 						icons = { ["+"] = "", a = "", h = "" },
  -- 					}),
  -- 				},
  -- 				right = {
  -- 					" ",
  -- 					wilder.popupmenu_scrollbar(),
  -- 				},
  -- 				pumblend = 10,
  -- 			}))
  -- 		)
  -- 	end,
  -- },

-- {
  -- 	"ibhagwan/fzf-lua",
  -- 	config = function()
  -- 		local fzf = require("fzf-lua")
  --
  -- 		local function opts(desc)
  -- 			return { desc = "FZF: " .. desc, silent = true }
  -- 		end
  -- 		vim.keymap.set("n", ";ff", function()
  -- 			fzf.files()
  -- 		end, opts("Files"))
  -- 		vim.keymap.set("n", ";bf", function()
  -- 			fzf.buffers()
  -- 		end, opts("Buffers"))
  -- 		vim.keymap.set("n", ";gg", function()
  -- 			fzf.grep()
  -- 		end, opts("Grep"))
  -- 		vim.keymap.set("n", ";lg", function()
  -- 			fzf.live_grep()
  -- 		end, opts("Live grep"))
  -- 		vim.keymap.set("n", ";bt", function()
  -- 			fzf.builtin()
  -- 		end, opts("Builtin"))
  -- 		vim.keymap.set("n", ";ht", function()
  -- 			fzf.help_tags()
  -- 		end, opts("Help"))
  -- 		vim.keymap.set("n", ";km", function()
  -- 			fzf.keymaps()
  -- 		end, opts("Keymaps"))
  -- 		vim.keymap.set("n", ";ft", function()
  -- 			fzf.filetypes()
  -- 		end, opts("Filetypes"))
  -- 		vim.keymap.set("n", ";mn", function()
  -- 			fzf.menus()
  -- 		end, opts("Menus"))
  -- 	end,
  -- },
}
