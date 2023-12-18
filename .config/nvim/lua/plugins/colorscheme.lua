return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = function(_, opts)
      if not opts.integrations then
        opts.integrations = {}
      end
      opts.integrations.hop = true
      opts.integrations.lsp_saga = true
      opts.integrations.nvimtree = true
      opts.integrations.overseer = true
      opts.integrations.mini = {
        enabled = true,
        indentscope_color = "sky",
      }
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      background = {
        light = "mocha",
        dark = "mocha",
      },
      transparent_background = true,
      term_colors = false,
      styles = {
        strings = { "italic" },
        numbers = { "italic" },
        booleans = { "italic" },
        loops = { "italic" },
        types = { "bold" },
        operators = { "bold" },
      },
      color_overrides = {
        mocha = {
          base = "#000000",
          text = "#f6d4ff",
          rosewater = "#ff795e",
          flamingo = "#ff8aa1",
          pink = "#ff85de",
          mauve = "#9dff00",
          red = "#d43939",
          maroon = "#ff6e92",
          peach = "#73ace6",
          yellow = "#ff795e",
          green = "#00ff80",
          teal = "#91ffe5",
          sky = "#96eeff",
          sapphire = "#6e86ff",
          blue = "#00b3ff",
          lavender = "#ff4089",
        },
      },
      custom_highlights = {},
      highlight_overrides = {
        mocha = function(_)
          return {
            Comment = { fg = "#2e4e70" },
            Constant = { fg = "#ffe136", style = { "bold" } },
            Number = { fg = "#6e86ff" },
            Boolean = { fg = "#b98aff" },
            Operator = { link = "Function" },
            Delimiter = { fg = "#ff8aa1" },
            Error = { fg = "#d43939", style = { "underline" } },
            Identifier = { fg = "#88ff78" },
            -- Conditional = { fg = "#b98aff", style = { "italic" } },
            -- Repeat = { fg = "#ff6e92", style = { "italic" } },
          }
        end,
      },
      integrations = {
        native_lsp = {
          enabled = false,
        },
      },
    },
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        "*",
      })
    end,
  },
}
