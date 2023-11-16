return {
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        override = {},
        default = true,
      })
    end,
  },
  {
    "goolord/alpha-nvim",
    config = function()
      require("alpha").setup(require("alpha.themes.dashboard").config)
    end,
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    keys = {
      { "<Tab>", "<CMD>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<CMD>BufferLineCyclePrev<CR>", desc = "Next tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local lualine = require("lualine")
      local function os_icon()
        return ""
      end

      lualine.setup({
        theme = "auto",
        options = {
          icons_enabled = true,
          theme = "solarized_dark",
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
          disabled_filetypes = {},
        },
        sections = {
          lualine_a = {
            os_icon,
            {
              "mode",
              fmt = function(str)
                return " " .. str
              end,
            },
          },
          lualine_b = {
            {
              "filename",
              file_status = true,
              path = 0,
            },
            "branch",
          },
          lualine_c = { "diff" },
          lualine_x = {
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = {
                error = " ",
                warn = " ",
                info = " ",
                hint = " ",
              },
            },
            "encoding",
            "filetype",
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {
              "filename",
              file_status = true, -- displays file status (readonly status, modified status)
              path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
            },
          },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = { "fugitive" },
      })
    end,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      local notify = require("notify")
      notify.setup({ background_colour = "#000000" })
      vim.keymap.set("n", "nx", function()
        notify.dismiss({ pending = true, silent = true })
      end, { desc = "Clear Notifications" })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      local noice = require("noice")
      noice.setup({
        cmdline = {
          enabled = false,
          view = "cmdline",
        },
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        messages = { enabled = false },
        popupmenu = { enabled = false },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = false,
        },
      })
    end,
  },
  {
    "stevearc/dressing.nvim",
    opts = {},
  },
  {
    "levouh/tint.nvim",
    config = function()
      local tint = require("tint")
      tint.setup({
        tint = -60,
        saturation = 1.0,
        transforms = tint.transforms.SATURATE_TINT,
        tint_background_colors = true,
        highlight_ignore_patterns = { "WinSeparator", "Status.*" },
        window_ignore_function = function(winid)
          local bufid = vim.api.nvim_win_get_buf(winid)
          local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
          local floating = vim.api.nvim_win_get_config(winid).relative ~= ""
          return buftype == "terminal" or floating
        end,
      })
    end,
  },
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

  -- {
  -- 	"feline-nvim/feline.nvim",
  -- 	config = function()
  -- 		require("feline").setup({})
  -- 	end,
  -- },
}
