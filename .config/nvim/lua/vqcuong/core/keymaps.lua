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
keymap.set("n", "<leader><tab>l", "<cmd>tablast<cr>", opts("Last Tab"))
keymap.set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", opts("First Tab"))
keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", opts("New Tab"))
keymap.set("n", "<leader><tab>]", "<cmd>tabnext<cr>", opts("Next Tab"))
keymap.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", opts("Close Tab"))
keymap.set("n", "<leader><tab>[", "<cmd>tabprevious<cr>", opts("Previous Tab"))

-- windows
keymap.set("n", "<leader>wH", ":vsplit<return>", opts("Split window on the left"))
keymap.set("n", "<leader>wL", ":vsplit<return><c-w>w", opts("Split window on the right"))
keymap.set("n", "<leader>wK", ":split<return>", opts("Split window to below"))
keymap.set("n", "<leader>wJ", ":split<return><c-w>w", opts("Split window to upper"))
keymap.set("n", "<leader>ww", "<c-w>p", { desc = "Other window", remap = true })
keymap.set("n", "<leader>wd", "<c-w>c", { desc = "Delete window", remap = true })
keymap.set("n", "<leader>w-", "<c-w>s", { desc = "Split window below", remap = true })
keymap.set("n", "<leader>w|", "<c-w>v", { desc = "Split window right", remap = true })
keymap.set("n", "<leader>-", "<c-w>s", { desc = "Split window below", remap = true })
keymap.set("n", "<leader>|", "<c-w>v", { desc = "Split window right", remap = true })
keymap.set("n", "<space><space>", "<c-w>w", opts("Other window"))
keymap.set("n", "<leader>wh", "<c-w>h", opts("Left window"))
keymap.set("n", "<leader>wl", "<c-w>l", opts("Right window"))
keymap.set("n", "<leader>wk", "<c-w>k", opts("Upper window"))
keymap.set("n", "<leader>wj", "<c-w>j", opts("Lower window"))
keymap.set("n", "<leader>w<left>", "<c-w><", opts("Resize window to left"))
keymap.set("n", "<leader>w<right>", "<c-w>>", opts("Resize window to right"))
keymap.set("n", "<leader>w<up>", "<c-w>+", opts("Resize window to up"))
keymap.set("n", "<leader>w<down>", "<c-w>-", opts("Resize window to down"))
-- keymap.set("n", "<leader>w<up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
-- keymap.set("n", "<leader>w<down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
-- keymap.set("n", "<leader>w<left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
-- keymap.set("n", "<leader>w<right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- disable inserting keys
keymap.set("n", "a", "<nop>")
keymap.set("n", "gI", "<nop>")
keymap.set("n", "gi", "<nop>")

-- better go up/down
keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "<down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "<up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- move Lines up/down and indent lines
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
keymap.set("v", ">", ">gv", opts("Indent lines"))
keymap.set("v", "<", "<gv", opts("De-indent lines"))

-- switch to other buffer
keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
keymap.set("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- clear search with <esc>
-- keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "escape and clear hlsearch" })
-- clear search, diff update and redraw taken from runtime/lua/_editor.lua
keymap.set(
  "n",
  "<esc>",
  "<cmd>nohlsearch<bar>diffupdate<bar>normal! <c-l><return>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- go next and previous search result
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- add undo break-points
keymap.set("i", ",", ",<c-g>u")
keymap.set("i", ".", ".<c-g>u")
keymap.set("i", ";", ";<c-g>u")

-- save file
keymap.set({ "i", "x", "n", "s" }, "<c-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- keywordprg
keymap.set("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- lazy
-- keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- trouble 
-- keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
-- keymap.set("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
-- keymap.set("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })
-- keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
-- keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- diagnostic
local goto_diagnostic = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
keymap.set("n", "]d", goto_diagnostic(true), { desc = "Next Diagnostic" })
keymap.set("n", "[d", goto_diagnostic(false), { desc = "Prev Diagnostic" })
keymap.set("n", "]e", goto_diagnostic(true, "ERROR"), { desc = "Next Error" })
keymap.set("n", "[e", goto_diagnostic(false, "ERROR"), { desc = "Prev Error" })
keymap.set("n", "]w", goto_diagnostic(true, "WARN"), { desc = "Next Warning" })
keymap.set("n", "[w", goto_diagnostic(false, "WARN"), { desc = "Prev Warning" })

-- quit
keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- highlights under cursor
keymap.set("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
