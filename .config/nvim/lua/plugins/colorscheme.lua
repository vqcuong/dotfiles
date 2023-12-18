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
        keywords = { "bold" },
        strings = { "italic" },
        numbers = { "italic" },
        booleans = { "italic" },
        types = { "bold" },
        operators = { "bold" },
      },
      color_overrides = {
        mocha = {
          base = "#000000",
          text = "#e3de86",
          rosewater = "#ff9885",
          flamingo = "#ff5e83",
          pink = "#fa6bff",
          mauve = "#aaff00",
          red = "#d43939",
          maroon = "#00fffb",
          peach = "#fa87b5",
          yellow = "#ff8f57",
          green = "#00ff9d",
          teal = "#76f5e8",
          sky = "#82dcff",
          sapphire = "#4a50ff",
          blue = "#00a2ff",
          lavender = "#ff63b4",
        },
      },
      custom_highlights = {},
      highlight_overrides = {
        mocha = function(_)
          return {
            Comment = { fg = "#2e4e70" },
            Constant = { fg = "#ff9885", style = { "bold" } },
            Number = { fg = "#0dff00" },
            Boolean = { fg = "#b98aff" },
            Operator = { link = "Function" },
            Delimiter = { fg = "#76f5e8" },
            Error = { fg = "#d43939", style = { "underline" } },
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
