if true then
  return {}
end

return {
  { "voldikss/vim-floaterm" },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    tag = "legacy",
    config = function()
      require("fidget").setup({
        text = {
          spinner = "meter",
        },
        window = {
          blend = 0,
        },
      })
    end,
  },
  { "neoclide/coc.nvim", build = "npm ci" },
  { "airblade/vim-gitgutter", opts = {} },
  "stevearc/oil.nvim",
  "gelguy/wilder.nvim",
  "feline-nvim/feline.nvim",
  "simrat39/symbols-ouline.nvim",
  "stevearc/aerial.nvim",
  "terrortylor/nvim-comment",
  "rktjmp/lush.nvim",
  "ibhagwan/fzf-lua",
  {
    "folke/zen-mode.nvim",
    keys = {
      { "<localleader>z", "<cmd>ZenMode<cr>", silent = true, desc = "Zen mode" },
    },
  },
}
