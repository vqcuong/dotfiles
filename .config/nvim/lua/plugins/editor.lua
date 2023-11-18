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

      vim.keymap.set("n", "mm", "<CMD>NvimTreeFocus<CR>", opts("Focus Tree"))
      vim.keymap.set("n", "<esc><esc>", "<CMD>NvimTreeFocus<CR>", opts("Focus Tree"))
      vim.keymap.set("n", "mg", "<CMD>lua require('nvim-tree.api').git.reload()<CR>", opts("Git Reload"))
      vim.keymap.set("n", "mn", "<CMD>NvimTreeToggle<CR>", opts("Toggle Tree"))
      vim.keymap.set("n", "mb", "<CMD>NvimTreeClipboard<CR>", opts("Show Clipboard"))
      vim.keymap.set("n", "mx", "<CMD>lua require('nvim-tree.api').fs.clear_clipboard()<CR>", opts("Clear Clipboard"))
    end,
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = function()
      -- stylua: ignore
      return {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" }
      }
    end,
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

  -- {
  --   "gelguy/wilder.nvim",
  --   config = function()
  --     local wilder = require("wilder")
  --     local gradient = {
  --       "#f4468f",
  --       "#fd4a85",
  --       "#ff507a",
  --       "#ff566f",
  --       "#ff5e63",
  --       "#ff6658",
  --       "#ff704e",
  --       "#ff7a45",
  --       "#ff843d",
  --       "#ff9036",
  --       "#f89b31",
  --       "#efa72f",
  --       "#e6b32e",
  --       "#dcbe30",
  --       "#d2c934",
  --       "#c8d43a",
  --       "#bfde43",
  --       "#b6e84e",
  --       "#aff05b",
  --     }
  --
  --     for i, fg in ipairs(gradient) do
  --       gradient[i] = wilder.make_hl("WilderGradient" .. i, "Pmenu", { { a = 1 }, { a = 1 }, { foreground = fg } })
  --     end
  --
  --     wilder.setup({
  --       modes = { ":", "/", "?" },
  --       next_key = "<Tab>",
  --       previous_key = "<S-Tab>",
  --     })
  --
  --     wilder.set_option("pipeline", {
  --       wilder.branch(
  --         wilder.python_file_finder_pipeline({
  --           file_command = { "fd", "-tf", "-H", "-E", ".git" },
  --           dir_command = { "fd", "fi", "--type", "d", "-H", "--max-depth", "5" },
  --           filters = { "fuzzy_filter", "difflib_sorter" },
  --         }),
  --         wilder.substitute_pipeline({
  --           pipeline = wilder.python_search_pipeline({
  --             skip_cmdtype_check = 1,
  --             pattern = wilder.python_fuzzy_pattern({
  --               start_at_boundary = 0,
  --             }),
  --           }),
  --         }),
  --         wilder.cmdline_pipeline({
  --           language = "python",
  --           fuzzy = 1,
  --         }),
  --         {
  --           wilder.check(function(ctx, x)
  --             return x == ""
  --           end),
  --           wilder.history(),
  --         },
  --         wilder.python_search_pipeline({
  --           pattern = wilder.python_fuzzy_pattern({
  --             start_at_boundary = 0,
  --           }),
  --         })
  --       ),
  --     })
  --     wilder.set_option(
  --       "renderer",
  --       -- wilder.popupmenu_renderer(wilder.popupmenu_palette_theme({
  --       -- 	highlights = {
  --       -- 		gradient = gradient,
  --       -- 	},
  --       -- 	border = "rounded",
  --       -- 	max_height = "65%",
  --       -- 	min_height = "20%",
  --       -- 	max_width = "50%",
  --       -- 	min_width = "20%",
  --       -- 	prompt_position = "top",
  --       -- 	highlighter = wilder.highlighter_with_gradient({
  --       -- 		wilder.basic_highlighter(),
  --       -- 	}),
  --       -- 	left = { " ", wilder.popupmenu_devicons() },
  --       -- 	pumblend = 10,
  --       -- }))
  --       wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
  --         highlights = {
  --           gradient = gradient,
  --         },
  --         border = "rounded",
  --         empty_message = wilder.popupmenu_empty_message_with_spinner(),
  --         highlighter = wilder.highlighter_with_gradient({
  --           wilder.basic_highlighter(),
  --         }),
  --         left = {
  --           " ",
  --           wilder.popupmenu_devicons(),
  --           wilder.popupmenu_buffer_flags({
  --             flags = " a + ",
  --             icons = { ["+"] = "", a = "", h = "" },
  --           }),
  --         },
  --         right = {
  --           " ",
  --           wilder.popupmenu_scrollbar(),
  --         },
  --         pumblend = 10,
  --       }))
  --     )
  --   end,
  -- },
}
