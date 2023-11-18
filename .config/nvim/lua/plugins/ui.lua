return {
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
      timeout = 2000,
      max_height = function()
        return math.floor(vim.o.lines * 0.5)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.5)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
  },
  {
    "akinsho/bufferline.nvim",
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
    opts = function()
      -- stylua: ignore
      local function os_icon() return "" end
      return {
        options = {
          globalstatus = false,
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
              file_status = true,
              path = 1,
            },
          },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = { "fugitive", "neo-tree", "lazy" },
      }
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      indent = {
        char = "▏",
        tab_char = "▏",
      },
    },
    config = function(_, opts)
      local ibl = require("ibl")
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
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
      ibl.setup(opts)
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
  {
    "echasnovski/mini.indentscope",
    opts = {
      symbol = "▏",
    },
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
        tint = -60,
        saturation = 1.0,
        transforms = tint.transforms.SATURATE_TINT,
        tin_background_colors = true,
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
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.defaults["<leader>n"] = { name = "+noice" }
      opts.defaults["<leader>sn"] = nil
    end,
  },
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline",
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
