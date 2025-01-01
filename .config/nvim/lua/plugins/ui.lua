return {

  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = { -- set to setup table
    },
  },

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

  -- {
  --   -- error when working with maximize.nvim
  --   "danilamihailov/beacon.nvim",
  --   config = function()
  --     require("beacon").setup({
  --       enabled = true,
  --       speed = 2,
  --       width = 30,
  --       winblend = 40,
  --       fps = 80,
  --       min_jump = 6,
  --       cursor_events = { "CursorMoved" }, window_events = { "WinEnter" },
  --       highlight = { bg = "#bfff00", ctermbg = 200 },
  --     })
  --   end,
  -- },

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
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = true,
    opts = {
      input = {
        enabled = function()
          return vim.bo.filetype == "NvimTree"
        end,
      },
      select = {
        enabled = function()
          return vim.bo.filetype == "NvimTree"
        end,
      },
    },
  },

  {
    "nvimdev/indentmini.nvim",
    config = function()
      require("indentmini").setup()
      vim.cmd.highlight("IndentLine guifg=#002c38")
      vim.cmd.highlight("IndentLineCurrent guifg=#57b6d9")
    end,
  },

  {
    "snacks.nvim",
    opts = {
      indent = { enabled = false },
      input = { enabled = false },
      notifier = { enabled = true },
      words = { enabled = true },
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
      bigfile = {
        enabled = true,
        notify = false,
      },
      toggle = {
        enabled = true,
        notify = false,
        color = {
          enabled = "blue",
          disabled = "yellow",
        },
      },
      zen = {
        win = { style = "zen" },
      },
    },
    keys = function()
      return {
        -- stylua: ignore
        { "<localleader>z", function() Snacks.zen.zen() end, desc = "Zen mode" },
      }
    end,
  },

  -- {
  --   "rcarriga/nvim-notify",
  --   opts = {
  --     background_colour = "#000000",
  --     timeout = 2000,
  --     max_height = function()
  --       return math.floor(vim.o.lines * 0.8)
  --     end,
  --     max_width = function()
  --       return math.floor(vim.o.columns * 0.8)
  --     end,
  --     on_open = function(win)
  --       vim.api.nvim_win_set_config(win, { zindex = 100 })
  --     end,
  --   },
  --   keys = {
  --     -- stylua: ignore
  --     { "<localleader>c", function() require("notify").dismiss({ silent=true, pending=true }) end, desc = "Clear notification" },
  --   },
  -- },

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
