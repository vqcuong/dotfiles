local keymap = vim.keymap
local function opts(desc)
  return { desc = desc, noremap = true, silent = true }
end

-- Increment/decrement
-- keymap.set("n", "+", "<C-a>", opts("Increase"))
-- keymap.set("n", "-", "<C-x>", opts("Decrease"))

-- Avoid x copy the deleted char to clipboard
keymap.set("n", "x", '"_x')

-- Delete a word backwards
keymap.set("n", "dp", 'vb"_d', opts("Previous Word"))

-- Select all
keymap.set("n", "aa", "gg<S-v>G", opts("Select all"))

-- New tab
keymap.set("n", "te", ":tabedit<Return>", opts("New tab"))
keymap.set("n", "tn", ":tabnext<Return>", opts("Next tab"))
keymap.set("n", "tp", ":tabprevious<Return>", opts("Previous tab"))

-- Split window
keymap.set("n", "w<Left>", ":vsplit<Return>", opts("Switch window to left"))
keymap.set("n", "w<Right>", ":vsplit<Return><C-w>w", opts("Switch window to right"))
keymap.set("n", "w<Up>", ":split<Return>", opts("Switch window to up"))
keymap.set("n", "w<Down>", ":split<Return><C-w>w", opts("Split window to down"))

-- Move window
-- keymap.set("n", "<Space>", "<C-w>w", opts("Cycle window"))
keymap.set("n", "<Space><left>", "<C-w>h", opts("Switch to left window"))
keymap.set("n", "<Space><right>", "<C-w>l", opts("Switch to right window"))
keymap.set("n", "<Space><up>", "<C-w>k", opts("Switch to up window"))
keymap.set("n", "<Space><down>", "<C-w>j", opts("Switch to down window"))

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><", opts("Resize window to left"))
keymap.set("n", "<C-w><right>", "<C-w>>", opts("Resize window to right"))
keymap.set("n", "<C-w><up>", "<C-w>+", opts("Resize window to up"))
keymap.set("n", "<C-w><down>", "<C-w>-", opts("Resize window to down"))

-- Disable inserting keys
keymap.set("n", "a", "<Nop>")
keymap.set("n", "gI", "<Nop>")
keymap.set("n", "gi", "<Nop>")

-- keymap.set("n", "<Tab>", ">>", opts("Indent Line"))
-- keymap.set("n", "<S-Tab>", "<<", opts("De-indent Line"))
keymap.set("i", "<S-Tab>", "<C-D>", opts("De-indent Line"))
keymap.set("v", "<Tab>", ">gv", opts("Indent Lines"))
keymap.set("v", "<S-Tab>", "<gv", opts("De-indent Lines"))

-- better up/down
keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move Lines
keymap.set("n", "<C-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
keymap.set("n", "<C-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
keymap.set("i", "<C-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
keymap.set("i", "<C-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
keymap.set("v", "<C-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
keymap.set("v", "<C-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
