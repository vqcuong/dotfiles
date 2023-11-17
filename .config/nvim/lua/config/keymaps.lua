-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local function opts(desc)
  return { desc = desc, noremap = true, silent = true }
end

-- avoid x copy the deleted char to clipboard
keymap.set("n", "x", '"_x')

-- delete a word backwards
keymap.set("n", "dp", 'vb"_d', opts("Delete previous word"))

-- select all
keymap.set("n", "aa", "ggVG", opts("Select all"))

-- quickly goto the start and end of line
keymap.set({ "n", "v" }, "<c-left>", "^", opts("Start of line"))
keymap.set("i", "<c-left>", "<esc>^i", opts("Start of line"))
keymap.set({ "n", "v" }, "<c-right>", "$", opts("End of line"))
keymap.set("i", "<c-right>", "<esc>$i", opts("End of line"))
