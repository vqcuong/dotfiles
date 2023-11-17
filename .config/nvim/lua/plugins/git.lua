return {
  { "tpope/vim-fugitive" },
  {
    "sindrets/diffview.nvim",
    config = function()
      vim.keymap.set("n", "<leader>gdv", "<CMD>DiffviewOpen<CR>", { desc = "Diffview view" })
      vim.keymap.set("n", "<leader>gdx", "<CMD>DiffviewClose<CR>", { desc = "Diffview exit" })
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim", -- optional
      -- "ibhagwan/fzf-lua", -- optional
    },
    config = function()
      vim.keymap.set("n", "<leader>gnv", "<CMD>Neogit<CR>", { desc = "Neogit view" })
      vim.keymap.set("n", "<leader>gnx", "<CMD>lua require('neogit').close()<CR>", { desc = "Neogit exit" })
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
