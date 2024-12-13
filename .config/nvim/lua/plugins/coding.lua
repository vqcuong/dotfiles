---@diagnostic disable: missing-fields

return {
  {
    "Wansmer/treesj",
    keys = {
      {
        "as",
        function()
          require("treesj").toggle({ split = { recursive = true } })
        end,
        desc = "Split-join toggle",
      },
    },
    opts = {
      use_default_keymaps = false,
      check_syntax_error = true,
      max_join_length = 120,
      cursor_behavior = "hold",
      notify = true,
      dot_repeat = true,
      on_error = nil,
    },
  },

  {
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
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    keys = function()
      return {}
    end,
  },
}
