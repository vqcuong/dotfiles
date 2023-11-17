return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      background = {
        light = "mocha",
        dark = "mocha",
      },
      transparent_background = true,
      show_end_of_buffer = false,
      term_colors = false,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.4,
      },
      no_italic = false,
      no_bold = false,
      no_underline = false,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      color_overrides = {
        mocha = {
          base = "#000000",
          text = "#fcba03",
          lavender = "#db6079",
          blue = "#4aabd9",
          rosewater = "#d48b74",
          red = "#b52f38",
          peach = "#e34993",
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
      integrations = {
        cmp = true,
        flash = true,
        gitsigns = true,
        hop = true,
        lsp_saga = true,
        mason = true,
        mini = {
          enabled = true,
          indentscope_color = "blue",
        },
        noice = true,
        notify = true,
        nvimtree = true,
        overseer = true,
        treesitter = true,
        treesitter_context = true,
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
