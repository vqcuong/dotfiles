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
  {
    "aserowy/tmux.nvim",
    opts = {
      copy_sync = {
        enable = false,
      },
      navigation = {
        -- cycles to opposite pane while navigating into the border
        cycle_navigation = true,
        -- enables default keybindings (C-hjkl) for normal mode
        enable_default_keybindings = false,
        -- prevents unzoom tmux when navigating beyond vim border
        persist_zoom = false,
      },
      resize = {
        -- enables default keybindings (A-hjkl) for normal mode
        enable_default_keybindings = false,
        resize_step_x = 1,
        resize_step_y = 1,
      },
    },
    keys = {
      { "<m-left>", "<cmd>lua require('tmux').move_left()<cr>", desc = "Move left", mode = { "n", "t" } },
      { "<m-right>", "<cmd>lua require('tmux').move_right()<cr>", desc = "Move right", mode = { "n", "t" } },
      { "<m-up>", "<cmd>lua require('tmux').move_top()<cr>", desc = "Move up", mode = { "n", "t" } },
      { "<m-down>", "<cmd>lua require('tmux').move_bottom()<cr>", desc = "Move down", mode = { "n", "t" } },
      { "<m-h>", "<cmd>lua require('tmux').resize_left()<cr>", desc = "Resize left", mode = { "n", "t" } },
      { "<m-l>", "<cmd>lua require('tmux').resize_right()<cr>", desc = "Resize right", mode = { "n", "t" } },
      { "<m-j>", "<cmd>lua require('tmux').resize_top()<cr>", desc = "Resize up", mode = { "n", "t" } },
      { "<m-k>", "<cmd>lua require('tmux').resize_bottom()<cr>", desc = "Resize down", mode = { "n", "t" } },
    },
  },
}
