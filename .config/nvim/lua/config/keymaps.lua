-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")
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

-- tabs
keymap.set("n", "<leader><tab>e", "<cmd>tabedit<return>", opts("New tab"))
keymap.set("n", "<leader><tab>n", "<cmd>tabnext<return>", opts("Next tab"))
keymap.set("n", "<leader><tab>p", "<cmd>tabprevious<return>", opts("Previous tab"))
keymap.set("n", "]<tab>", "<cmd>tabnext<return>", opts("Next tab"))
keymap.set("n", "[<tab>", "<cmd>tabprevious<return>", opts("Previous tab"))

-- disable some window default in lazyvim
keymap.del("n", "<c-h>", {})
keymap.del("n", "<c-j>", {})
keymap.del("n", "<c-k>", {})
keymap.del("n", "<c-l>", {})
keymap.del("n", "<c-up>", {})
keymap.del("n", "<c-down>", {})
keymap.del("n", "<c-left>", {})
keymap.del("n", "<c-right>", {})
-- windows
keymap.set("n", "<leader>wH", ":vsplit<return>", opts("Split window left"))
keymap.set("n", "<leader>wL", ":vsplit<return><c-w>w", opts("Split window right"))
keymap.set("n", "<leader>wK", ":split<return><c-w>w", opts("Split window above"))
keymap.set("n", "<leader>wJ", ":split<return>", opts("Split window below"))
keymap.set("n", "<leader>wh", "<c-w>h", opts("Left window"))
keymap.set("n", "<leader>wl", "<c-w>l", opts("Right window"))
keymap.set("n", "<leader>wk", "<c-w>k", opts("Above window"))
keymap.set("n", "<leader>wj", "<c-w>j", opts("Below window"))
keymap.set("n", "<leader>w<left>", "<c-w><", opts("Resize window left"))
keymap.set("n", "<leader>w<right>", "<c-w>>", opts("Resize window right"))
keymap.set("n", "<leader>w<up>", "<c-w>+", opts("Resize window above"))
keymap.set("n", "<leader>w<down>", "<c-w>-", opts("Resize window below"))
-- keymap.set("n", "<leader>w<up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
-- keymap.set("n", "<leader>w<down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
-- keymap.set("n", "<leader>w<left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
-- keymap.set("n", "<leader>w<right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- disable move lines default in lazyvim
keymap.del({ "n", "v", "i" }, "<a-j>", {})
keymap.del({ "n", "v", "i" }, "<a-k>", {})
-- move lines up/down and indent lines
keymap.set("n", "<c-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
keymap.set("n", "<c-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
keymap.set("i", "<c-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
keymap.set("i", "<c-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
keymap.set("v", "<c-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
keymap.set("v", "<c-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
keymap.set("n", "<c-l>", ">>", opts("Indent line"))
keymap.set("n", "<c-h>", "<<", opts("De-indent line"))
keymap.set("i", "<c-h>", "<c-d>", opts("De-indent line"))
keymap.set("v", "<c-l>", ">gv", opts("Indent lines"))
keymap.set("v", "<c-h>", "<gv", opts("De-indent lines"))

-- disable some buffers default in lazyvim
keymap.del("n", "<S-h>", {})
keymap.del("n", "<S-l>", {})

-- disable keywordprg in lazyvim
keymap.del("n", "<leader>K", {})

-- replace formatting default in lazyvim
keymap.del({ "n", "v" }, "<leader>cf", {})
keymap.set({ "n", "v" }, "<localleader>f", function()
  Util.format({ force = true })
end, { desc = "Format" })

-- disable floating terminal in lazyvim
keymap.del("n", "<leader>ft", {})
keymap.del("n", "<leader>fT", {})
keymap.del("n", "<c-/>", {})
keymap.del("n", "<c-_>", {})
keymap.del("t", "<esc><esc>", {})
keymap.del("t", "<c-h>", {})
keymap.del("t", "<c-j>", {})
keymap.del("t", "<c-k>", {})
keymap.del("t", "<c-l>", {})
keymap.del("t", "<c-/>", {})
keymap.del("t", "<c-_>", {})

-- disable vim builtin inserting keys
keymap.set("n", "a", "<nop>")
-- keymap.set("n", "gI", "<nop>")
keymap.set("n", "gi", "<nop>")

-- hide termimal quickly with <esc>
keymap.set("t", "<esc><esc>", "<cmd>lua require('FTerm').toggle()<cr>", { silent = true })
