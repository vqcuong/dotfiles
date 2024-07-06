return {
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "echasnovski/mini.surround", enabled = false },
  { "echasnovski/mini.icons", enabled = false },
  { "RRethy/vim-illuminate", enabled = false },
  {
    "akinsho/bufferline.nvim",
    enabled = false,
    keys = {
      { "<Tab>", "<CMD>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<CMD>BufferLineCyclePrev<CR>", desc = "Next tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },
}
