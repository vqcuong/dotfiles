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
        add_key("n", "gc", api.tree.toggle_git_clean_filter, "Toggle git modified")
        add_key("n", "gi", api.tree.toggle_gitignore_filter, "Toggle git ignored")
        add_key("n", "E", api.tree.expand_all, "Expand all")
        add_key("n", "W", api.tree.collapse_all, "Collapse all")
        add_key("n", "q", api.tree.close, "Quit")
        add_key("n", "R", api.tree.reload, "Refresh")
        add_key("n", "S", api.tree.search_node, "Search")
        add_key("n", "D", api.tree.toggle_hidden_filter, "Toggle hidden")
        add_key("n", "B", api.tree.toggle_no_buffer_filter, "Toggle buffers")
        add_key("n", "U", api.tree.toggle_custom_filter, "Toggle custom filter")

        add_key("n", "<cr>", api.node.open.edit, "Open")
        add_key("n", "<tab>", api.node.open.preview, "Preview")
        add_key("n", "<right>", api.node.open.preview, "Preview")
        add_key("n", "<left>", api.node.navigate.parent, "Goto parent")
        add_key("n", "I", api.node.show_info_popup, "Show info")
        add_key("n", "O", api.node.open.replace_tree_buffer, "Open in place")
        add_key("n", "T", api.node.open.tab, "Open in new tab")
        add_key("n", "V", api.node.open.vertical, "Open vertically")
        add_key("n", "H", api.node.open.horizontal, "Open horizontally")
        add_key("n", "<", api.node.navigate.sibling.prev, "Prev sibling")
        add_key("n", ">", api.node.navigate.sibling.next, "Next sibling")
        add_key("n", "[c", api.node.navigate.git.prev, "Prev git")
        add_key("n", "]c", api.node.navigate.git.next, "Next git")
        add_key("n", "[e", api.node.navigate.diagnostics.prev, "Prev diagnostic")
        add_key("n", "]e", api.node.navigate.diagnostics.next, "Next diagnostic")
        add_key("n", "K", api.node.navigate.sibling.first, "First sibling")
        add_key("n", "J", api.node.navigate.sibling.last, "Last sibling")
        add_key("n", "P", api.node.navigate.parent, "Parent dir")
        add_key("n", "<bs>", api.node.navigate.parent_close, "Close Dir")
        add_key("n", "C", api.node.run.system, "Open with vscode")
        add_key("n", ".", api.node.run.cmd, "Run command")

        add_key("n", "nn", api.fs.create, "New")
        add_key("n", "cc", api.fs.copy.node, "Copy")
        add_key("n", "cp", api.fs.copy.absolute_path, "Copy absolute path")
        add_key("n", "cr", api.fs.copy.relative_path, "Copy relative path")
        add_key("n", "cn", api.fs.copy.filename, "Copy file name")
        add_key("n", "rr", api.fs.rename, "Rename")
        add_key("n", "rb", api.fs.rename_basename, "Rename base")
        add_key("n", "xx", api.fs.cut, "Cut")
        add_key("n", "pp", api.fs.paste, "Paste")
        add_key("n", "dd", api.fs.remove, "Delete")
        add_key("n", "dt", api.fs.trash, "Trash")

        add_key("n", "bd", api.marks.bulk.delete, "Delete bookmarked")
        add_key("n", "bt", api.marks.bulk.trash, "Trash bookmarked")
        add_key("n", "bv", api.marks.bulk.move, "Move bookmarked")
        add_key("n", "bb", api.marks.toggle, "Toggle bookmark")

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
    end,
    keys = {
      { "<leader>ef", "<cmd>NvimTreeFocus<cr>", desc = "Focus" },
      { "<leader>eg", "<cmd>lua require('nvim-tree.api').git.reload()<cr>", desc = "Git reload" },
      { "<leader>ee", "<cmd>NvimTreeToggle<cr>", desc = "Toggle" },
      { "<leader>ec", "<cmd>NvimTreeClipboard<cr>", desc = "Show clipboard" },
      { "<leader>ex", "<cmd>lua require('nvim-tree.api').fs.clear_clipboard()<cr>", desc = "Clear clipboard" },
      { "<localleader>e", "<leader>ef", desc = "Explorer focus", remap = true },
      { "<localleader><localleader>", "<leader>ee", desc = "Explorer toggle", remap = true },
    },
  },

  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.defaults["<leader>e"] = { name = "+explorer" }
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

  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<localleader>x", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
      { "<localleader>X", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
    },
  },

  {
    "folke/todo-comments.nvim",
    -- stylua: ignore
    keys = {
      { "<localleader>t", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<localleader>T", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
    },
  },

  {
    "sontungexpt/stcursorword",
    event = "VeryLazy",
    opts = {
      highlight = {
        underline = false,
        bg = "#777777",
      },
    },
    config = true,
  },

  {
    "LukasPietzschmann/telescope-tabs",
    opts = {},
    keys = {
      {
        "<localleader><tab>",
        "<cmd>lua require('telescope-tabs').list_tabs()<cr>",
        desc = "List tabs",
      },
      {
        "<leader>s<tab>",
        "<cmd>lua require('telescope-tabs').list_tabs()<cr>",
        desc = "Tabs",
      },
    },
  },
}
