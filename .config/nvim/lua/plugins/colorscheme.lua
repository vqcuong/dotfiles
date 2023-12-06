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
        indentscope_color = "blue",
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
      color_overrides = {
        mocha = {
          base = "#000000",
          text = "#fcba03",
          lavender = "#ffa36e",
          blue = "#69c9f5",
          rosewater = "#d48b74",
          red = "#f76a78",
          peach = "#f22287",
          mauve = "#d04dff",
          green = "#75c45c",
        },
      },
      custom_highlights = {},
      highlight_overrides = {
        mocha = function(_)
          return {
            Comment = { fg = "#7a94bf" },
          }
        end,
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
