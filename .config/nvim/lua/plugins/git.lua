return {
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    keys = {
      { "gg", "<cmd>GitBlameToggle<cr>", desc = "Git blame toggle", mode = { "n", "v" } },
    },
    opts = {
      enabled = true,
      message_template = " <summary> • <date> • <author> • <<sha>>",
      date_format = "%m-%d-%Y %H:%M:%S",
      virtual_text_column = 1,
    },
  },
  { "tpope/vim-fugitive" },
  {
    "sindrets/diffview.nvim",
    config = function()
      vim.keymap.set("n", "<leader>gd", "<CMD>DiffviewOpen<CR>", { desc = "Diffview view" })
      vim.keymap.set("n", "<leader>gxd", "<CMD>DiffviewClose<CR>", { desc = "Diffview exit" })
    end,
  },
  {
    "NeogitOrg/neogit",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim", -- optional
      -- "ibhagwan/fzf-lua", -- optional
    },
    keys = {
      { "<leader>gn", "<cmd>Neogit<cr>", desc = "Neogit view" },
      { "<leader>gxn", "<cmd>lua require('neogit').close()<cr>", desc = "Neogit exit" },
    },
    config = function()
      require("neogit").setup({})
    end,
  },
  {
    "rbong/vim-flog",
    lazy = true,
    cmd = { "Flog", "Flogsplit", "Floggit" },
    dependencies = {
      "tpope/vim-fugitive",
    },
  },
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}
