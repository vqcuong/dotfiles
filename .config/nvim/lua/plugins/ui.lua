return {
  {
    -- a complete code navigation and outline
    "nvimdev/lspsaga.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    opts = {
      symbol_in_winbar = {
        enable = true,
        folder_level = 2,
        color_mode = false,
      },
      code_action = {
        enable = true,
      },
      diagnostic = {
        show_code_action = true,
      },
      definition = {
        keys = {
          edit = "e",
          vsplit = "v",
          split = "h",
          tabe = "t",
          quit = { "q", "<esc>" },
          close = { "q", "<esc>" },
        },
      },
      finder = {
        keys = {
          vsplit = "v",
          split = "h",
          tabe = "t",
          tabnew = "n",
          quit = { "q", "<esc>" },
          close = { "q", "<esc>" },
        },
      },
      outline = {
        close_after_jump = true,
        keys = {
          jump = "e",
        },
      },
      rename = {
        keys = {
          quit = "<esc>",
        },
      },
      lightbulb = {
        sign = false,
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.add({
        { "<leader>m", group = "lspsaga" },
        { "<leader>m<right>", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Next diagnostic" },
        { "<leader>m<left>", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "Previous diagnostic" },
        { "<leader>ml", "<cmd>Lspsaga show_line_diagnostics<cr>", desc = "Line diagnostic" },
        { "<leader>mf", "<cmd>Lspsaga finder<cr>", desc = "Finder" },
        { "<leader>md", "<cmd>Lspsaga hover_doc<cr>", desc = "Docs" },
        { "<leader>mD", "<cmd>Lspsaga goto_type_definition<cr>", desc = "Goto type definition" },
        { "<leader>mp", "<cmd>Lspsaga peek_definition<cr>", desc = "Peek definition" },
        { "<leader>mP", "<cmd>Lspsaga peek_type_definition<cr>", desc = "Peek type definition" },
        { "<leader>mr", "<cmd>Lspsaga rename<cr>", desc = "Rename" },
        { "<leader>ma", "<cmd>Lspsaga code_action<cr>", desc = "Code action" },
        { "<leader>mo", "<cmd>Lspsaga outline<cr>", desc = "Outline" },
        { "<localleader>d", "<cmd>Lspsaga hover_doc<cr>", desc = "Docs" },
        { "<localleader>D", "<cmd>Lspsaga goto_type_definition<cr>", desc = "Goto type definition" },
        { "<localleader>p", "<cmd>Lspsaga peek_definition<cr>", desc = "Peek definition" },
        { "<localleader>P", "<cmd>Lspsaga peek_type_definition<cr>", desc = "Peek type definition" },
        { "<localleader>o", "<cmd>Lspsaga outline<cr>", desc = "Outline" },
        { "<localleader>r", "<cmd>Lspsaga rename<cr>", desc = "Rename" },
      })
      require("lspsaga").setup(opts)
    end,
  },

  {
    -- a decorating code symbols
    "onsails/lspkind.nvim",
    config = function()
      require("lspkind").init({
        mode = "symbol",
        preset = "codicons",
        symbol_map = {
          Text = "󰉿",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",
          Field = "󰜢",
          Variable = "",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "󰈇",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "",
        },
      })
    end,
  },
  {
    -- an explorer extension
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
        { "<localleader>e", "<leader>ee", desc = "Explorer Toggle", remap = true },
      })
    end,
  },

  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = { -- set to setup table
    },
  },

  {
    -- toggle colorizing text focusing to the cursor
    "folke/twilight.nvim",
    opts = {
      dimming = {
        alpha = 0.5,
      },
      context = 20,
    },
    keys = { { "<leader>t", "<cmd>Twilight<cr>", desc = "Twilight Mode Toggle" } },
  },

  {
    -- integrate with tmux direction keys
    "alexghergh/nvim-tmux-navigation",
    config = function()
      require("nvim-tmux-navigation").setup({
        disable_when_zoomed = true,
        keybindings = {
          left = "<m-left>",
          down = "<m-down>",
          up = "<m-up>",
          right = "<m-right>",
          last_active = "<m-l>",
          next = "<m-.>",
        },
      })
    end,
  },

  {
    -- a configurable decorator for tab bar
    "nanozuki/tabby.nvim",
    config = function()
      require("tabby.tabline").set(function(line)
        return {
          {
            { "   ", hl = { fg = "#47ff78" } },
          },
          line.tabs().foreach(function(tab)
            local tab_node = {
              { "", hl = { fg = tab.is_current() and "#ff557d" or "#999999" } },
              { string.format(" %s ", tab.number()), hl = { fg = tab.is_current() and "#ff457d" or "#999999" } },
            }
            if not tab.is_current() then
              return tab_node
            end
            local win_nodes = line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
              local bo = vim.bo[win.buf().id]
              if vim.tbl_contains({ "NvimTree", "neo-tree" }, bo.ft) or vim.tbl_contains({ "nofile" }, bo.bt) then
                return {}
              end
              return {
                { "❯", hl = { fg = win.is_current() and "#fff457" or "#999999" } },
                {
                  string.format(" %s", win.file_icon()),
                  hl = { fg = win.is_current() and "#00aee3" or "#999999" },
                },
                {
                  string.format(" %s ", win.buf_name()),
                  hl = { fg = win.is_current() and "#fff457" or "#999999" },
                },
              }
            end)
            return { tab_node, win_nodes }
          end),
          line.spacer(),
        }
      end)
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      -- stylua: ignore
      -- local function os_icon() return "" end
      -- stylua: ignore
      local function vim_icon() return "" end

      local function flutter_device()
        if vim.g.flutter_tools_decorations.device ~= nil then
          return vim.g.flutter_tools_decorations.device.name
        end
        return ""
      end

      -- local function codeium()
      --   return LazyVim.lualine.cmp_source("codeium")
      -- end

      -- local function get_schema()
      --   local schema = require("yaml-companion").get_buf_schema(0)
      --   if schema.result[1].name == "none" then
      --     return ""
      --   end
      --   return schema.result[1].name
      -- end

      local auto_theme_custom = require("lualine.themes.auto")
      auto_theme_custom.normal.c.bg = "none"

      return {
        options = {
          theme = auto_theme_custom,
          globalstatus = false,
          disabled_filetypes = {
            "notify",
            "NvimTree",
            "toggleterm",
            "sagaoutline",
            "NeogitStatus",
            "DiffviewFiles",
            "neo-tree",
            "neo-tree-popup",
            "diff",
            "git",
            "fugitive",
            "fugitiveblame",
            "log",
          },
        },
        sections = {
          lualine_a = { vim_icon, "mode" },
          lualine_b = {
            -- {
            --   "mode",
            --   fmt = function(str)
            --     return " " .. str
            --   end,
            -- },
          },
          lualine_c = {
            "diff",
            {
              "filename",
              file_status = true,
              path = 0,
            },
            "branch",
          },
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
            -- get_schema,
            "progress",
          },
          lualine_y = {},
          lualine_z = {
            -- "location",
            flutter_device,
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {
              "filename",
              file_status = true,
              path = 1,
            },
          },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = { "nvim-tree", "fugitive", "neo-tree", "lazy" },
      }
    end,
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      local rd = require("rainbow-delimiters")
      require("rainbow-delimiters.setup").setup({
        strategy = {
          [""] = rd.strategy["global"],
          vim = rd.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "rainbowdelimiterorange",
          "rainbowdelimitergreen",
          "RainbowDelimiterCyan",
          "rainbowdelimiterviolet",
          "rainbowdelimiteryellow",
          "rainbowdelimiterred",
          "rainbowdelimiterblue",
        },
      })
    end,
  },

  {
    -- automatically dim unactive windows
    "levouh/tint.nvim",
    config = function()
      local tint = require("tint")
      tint.setup({
        tint = -40,
        saturation = 0.6,
        transforms = tint.transforms.SATURATE_TINT,
        tin_background_colors = true,
        highlight_ignore_patterns = { "WinSeparator", "Status.*" },
        window_ignore_function = function(winid)
          local bufid = vim.api.nvim_win_get_buf(winid)
          local buftype = vim.api.nvim_get_option_value("buftype", { buf = bufid })
          local floating = vim.api.nvim_win_get_config(winid).relative ~= ""
          return buftype == "terminal" or floating
        end,
      })
    end,
  },

  -- {
  --   "hedyhli/outline.nvim",
  --   keys = { { "<localleader><localleader>", "<cmd>Outline<CR>", desc = "Toggle Outline" } },
  --   config = function()
  --     require("outline").setup({})
  --   end,
  -- },

  {
    -- rich ui features for nvim: indent, input, notifier, scroll, ...
    "snacks.nvim",
    opts = {
      bigfile = {
        enabled = true,
        notify = false,
      },
      explorer = { enabled = false },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = {
        timeout = 1000,
        enabled = true,
        width = { min = 20, max = 0.3 },
        height = { min = 1, max = 0.4 },
        refresh = 200,
      },
      quickfile = {},
      scroll = { enabled = false },
      statuscolumn = {
        enabled = true,
        left = { "fold", "sign" },
        right = { "git" },
        folds = {
          open = true,
          git_hl = true,
        },
        git = {
          patterns = { "GitSign", "MiniDiffSign" },
        },
        refresh = 300,
      },
      words = { enabled = true },
      styles = {
        input = {
          relative = "cursor",
          row = 1,
          col = 4,
          width = 25,
          b = {
            completion = false,
          },
        },
      },
    },
    keys = function()
      -- stylua: ignore
      return {
        { "<localleader>Z", function() Snacks.zen.zen() end, desc = "Snacks: zen mode" },
        { "<localleader>z", function() Snacks.zen.zoom() end, desc = "Snacks: zen mode" },
        { "<localleader>g", function() Snacks.gitbrowse() end, desc = "Snacks: open git browse" },

        -- the explorer is hard to use
        -- { "<localleader>e", function() Snacks.explorer() end, desc = "File Explorer" },
        -- the dim feature in snacks seems to be unstable when using with keybindings
        -- { "<localleader>a", function()
        --   vim.g.snacks_dim = not vim.g.snacks_dim
        --   if vim.g.snacks_dim == true then
        --     Snacks.dim.enable()
        --   else
        --     Snacks.dim.disable()
        --   end
        -- end, desc = "Snack Dim Toggle" },
      }
    end,
  },

  {
    -- gui decorator for some popup and input in nvim
    "folke/noice.nvim",
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline",
        format = {
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = "👀", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = "👀", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
          input = {},
        },
      },
      presets = {
        command_palette = false,
      },
    },
    config = function(_, opts)
      require("noice").setup(opts)
      -- stylua: ignore
      require("which-key").add({
        { "<leader>n", group = "noice" },
        { "<leader>nl", "<cmd>lua require('noice').cmd('last')<cr>", desc="Last Message" },
        { "<leader>nh", "<cmd>lua require('noice').cmd('history')<cr>", desc="History" },
        { "<leader>na", "<cmd>lua require('noice').cmd('all')<cr>", desc="Show All Message" },
        { "<leader>nd", "<cmd>lua require('noice').cmd('dismiss')<cr>", desc="Dismiss All Message" },
      })
    end,
  },
}
