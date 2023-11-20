return {

  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    opts = {
      -- autotag = { enable = true },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
    },
  },

  {
    "Wansmer/treesj",
    keys = {
      {
        "gS",
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
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.defaults["<leader>d"] = { name = "+lspsaga" }
    end,
  },

  {
    "nvimdev/lspsaga.nvim",
    lazy = false,
    opts = {
      symbol_in_winbar = {
        enable = true,
        folder_level = 3,
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
          quit = "q",
          close = "q",
        },
      },
      finder = {
        keys = {
          vsplit = "v",
          split = "h",
          tabe = "t",
          tabnew = "n",
          quit = "q",
          close = "q",
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
          quit = "q",
        },
      },
      lightbulb = {
        sign = false,
      },
    },
    keys = {
      { "<leader>d<right>", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "next diagnostic" },
      { "<leader>d<left>", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "previous diagnostic" },
      { "<leader>dl", "<cmd>Lspsaga show_line_diagnostics<cr>", desc = "line diagnostic" },
      { "<leader>dd", "<cmd>Lspsaga hover_doc<cr>", desc = "docs" },
      { "<leader>df", "<cmd>Lspsaga finder<cr>", desc = "finder" },
      { "<leader>dt", "<cmd>Lspsaga goto_type_definition<cr>", desc = "type definition" },
      { "<leader>dp", "<cmd>Lspsaga peek_definition<cr>", desc = "peek definition" },
      { "<leader>de", "<cmd>Lspsaga rename<cr>", desc = "rename" },
      { "<leader>da", "<cmd>Lspsaga code_action<cr>", desc = "code action" },
      { "<leader>do", "<cmd>Lspsaga outline<cr>", desc = "outline" },
    },
  },
}
