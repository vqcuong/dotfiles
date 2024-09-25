return {
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 100,
    config = function()
      require("solarized-osaka").setup({
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
        sidebars = { "qf", "help" },
        hide_inactive_statusline = true,
        on_highlights = function(hl, _)
          hl.StatusLine = {}
          hl.MiniStatuslineFilename = {}
          hl.MiniStatuslineFileinfo = {}
        end,
      })
    end,
  },

  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   priority = 1000,
  --   config = true,
  --   opts = {
  --     transparent_mode = true,
  --   },
  -- },

  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   opts = {
  --     flavour = "mocha",
  --     background = {
  --       light = "mocha",
  --       dark = "mocha",
  --     },
  --     transparent_background = true,
  --     term_colors = false,
  --     styles = {
  --       strings = { "italic" },
  --       numbers = { "italic" },
  --       booleans = { "italic" },
  --       loops = { "italic" },
  --       types = { "bold" },
  --       operators = { "bold" },
  --     },
  --     color_overrides = {
  --       mocha = {
  --         base = "#000000",
  --         text = "#f6d4ff",
  --         rosewater = "#ff795e",
  --         flamingo = "#ff8aa1",
  --         pink = "#ff85de",
  --         mauve = "#9dff00",
  --         red = "#d43939",
  --         maroon = "#ff6e92",
  --         peach = "#73ace6",
  --         yellow = "#ff795e",
  --         green = "#00ff80",
  --         teal = "#91ffe5",
  --         sky = "#96eeff",
  --         sapphire = "#6e86ff",
  --         blue = "#00b3ff",
  --         lavender = "#ff4089",
  --       },
  --     },
  --     custom_highlights = {},
  --     highlight_overrides = {
  --       mocha = function(_)
  --         return {
  --           Comment = { fg = "#2e4e70" },
  --           Constant = { fg = "#ffe136", style = { "bold" } },
  --           Number = { fg = "#6e86ff" },
  --           Boolean = { fg = "#b98aff" },
  --           Operator = { link = "Function" },
  --           Delimiter = { fg = "#ff8aa1" },
  --           Error = { fg = "#d43939", style = { "underline" } },
  --           Identifier = { fg = "#88ff78" },
  --           -- Conditional = { fg = "#b98aff", style = { "italic" } },
  --           -- Repeat = { fg = "#ff6e92", style = { "italic" } },
  --         }
  --       end,
  --     },
  --     integrations = {
  --       native_lsp = {
  --         enabled = false,
  --       },
  --       hop = true,
  --       lsp_saga = true,
  --       nvimtree = true,
  --       overseer = true,
  --       mini = {
  --         enabled = true,
  --         indentscope_color = "sky",
  --       },
  --     },
  --   },
  -- },
}
