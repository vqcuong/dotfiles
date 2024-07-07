return {

  {
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
    "elijahdanko/ttymux.nvim",
    -- stylua: ignore
    keys = {
      { "<m-left>", function() require("ttymux.window").navigate("h") end },
      { "<m-down>", function() require("ttymux.window").navigate("j") end },
      { "<m-up>", function() require("ttymux.window").navigate("k") end },
      { "<m-right>", function() require("ttymux.window").navigate("l") end },
      { "<m-.>", function() require("ttymux.window").next_window() end },
    },
    config = function()
      require("ttymux").setup({
        default_keymap = false,
      })
    end,
  },

  -- {
  --   "aserowy/tmux.nvim",
  --   opts = {
  --     copy_sync = {
  --       enable = false,
  --     },
  --     navigation = {
  --       cycle_navigation = true,
  --       enable_default_keybindings = false,
  --       persist_zoom = false,
  --     },
  --     resize = {
  --       enable_default_keybindings = false,
  --       resize_step_x = 1,
  --       resize_step_y = 1,
  --     },
  --   },
  --   keys = {
  --     { "<m-left>", "<cmd>lua require('tmux').move_left()<cr>", desc = "Move left", mode = { "n", "t" } },
  --     { "<m-right>", "<cmd>lua require('tmux').move_right()<cr>", desc = "Move right", mode = { "n", "t" } },
  --     { "<m-up>", "<cmd>lua require('tmux').move_top()<cr>", desc = "Move up", mode = { "n", "t" } },
  --     { "<m-down>", "<cmd>lua require('tmux').move_bottom()<cr>", desc = "Move down", mode = { "n", "t" } },
  --   },
  -- },

  {
    "danilamihailov/beacon.nvim",
    config = function()
      require("beacon").setup({
        enabled = true, --- (boolean | fun():boolean) check if enabled
        speed = 2, --- integer speed at wich animation goes
        width = 50, --- integer width of the beacon window
        winblend = 60, --- integer starting transparency of beacon window :h winblend
        fps = 60, --- integer how smooth the animation going to be
        min_jump = 8, --- integer what is considered a jump. Number of lines
        cursor_events = { "CursorMoved" }, -- table<string> what events trigger check for cursor moves
        window_events = { "WinEnter", "FocusGained" }, -- table<string> what events trigger cursor highlight
        highlight = { bg = "#00ff0d", ctermbg = 15 }, -- vim.api.keyset.highlight table passed to vim.api.nvim_set_hl
      })
    end,
  },
  {
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

      return {
        options = {
          globalstatus = false,
          disabled_filetypes = {
            "notify",
            "NvimTree",
            "toggleterm",
            "OverseerList",
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
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }
      local opts = {
        indent = {
          char = "▏",
          tab_char = "▏",
        },
        scope = {
          show_start = false,
          show_end = false,
          highlight = highlight,
        },
        exclude = {
          filetypes = {
            "alpha",
            "dashboard",
            "fzf",
            "help",
            "lazy",
            "lazyterm",
            "mason",
            "neo-tree",
            "notify",
            "toggleterm",
            "Trouble",
            "trouble",
            "NvimTree",
          },
        },
      }
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#e35b91" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#face7f" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#2eb2ff" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#f09886" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#12e04c" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#b65fe8" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#21e9ff" })
      end)
      vim.g.rainbow_delimiters = { highlight = highlight }
      require("ibl").setup(opts)
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },

  {
    "echasnovski/mini.indentscope",
    opts = {
      symbol = "▏",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "alpha",
          "dashboard",
          "fzf",
          "help",
          "lazy",
          "lazyterm",
          "mason",
          "neo-tree",
          "notify",
          "toggleterm",
          "Trouble",
          "trouble",
          "NvimTree",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
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
          "rainbowdelimiterred",
          "rainbowdelimiteryellow",
          "rainbowdelimiterblue",
          "rainbowdelimiterorange",
          "rainbowdelimitergreen",
          "rainbowdelimiterviolet",
          "RainbowDelimiterCyan",
        },
      })
    end,
  },

  {
    "levouh/tint.nvim",
    config = function()
      local tint = require("tint")
      tint.setup({
        tint = -40,
        saturation = 0.5,
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

  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.defaults["<leader>n"] = { name = "+noice" }
      opts.defaults["<leader>sn"] = nil
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
      timeout = 2000,
      max_height = function()
        return math.floor(vim.o.lines * 0.8)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.8)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
    keys = {
      -- stylua: ignore
      { "<localleader>c", function() require("notify").dismiss({ silent=true, pending=true }) end, desc = "Clear notification" },
    },
  },

  {
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
    keys = function()
      -- stylua: ignore
      return {
        { "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
        { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History" },
        { "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All" },
        { "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
      }
    end,
  },
}
