local keymap = vim.keymap

keymap.set("n", "x", '"_x')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- New tab
keymap.set("n", "te", ":tabedit")
-- Split window
keymap.set("n", "s<Left>", ":vsplit<Return>")
keymap.set("n", "s<Right>", ":vsplit<Return><C-w>w")
keymap.set("n", "s<Up>", ":split<Return>")
keymap.set("n", "s<Down>", ":split<Return><C-w>w")

-- Move window
keymap.set("n", "<Space>", "<C-w>w")
keymap.set("", "g<Left>", "<C-w>h")
keymap.set("", "g<Right>", "<C-w>l")
keymap.set("", "g<Up>", "<C-w>j")
keymap.set("", "g<Down>", "<C-w>k")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Disable inserting keys
keymap.set("n", "a", "<Nop>")
keymap.set("n", "gI", "<Nop>")
keymap.set("n", "gi", "<Nop>")

local function opts(desc)
	return { desc = desc, noremap = true, silent = true }
end
-- keymap.set("n", "<Tab>", ">>", opts("Indent Line"))
-- keymap.set("n", "<S-Tab>", "<<", opts("De-indent Line"))
keymap.set("i", "<S-Tab>", "<C-D>", opts("De-indent Line"))
keymap.set("v", "<Tab>", ">gv", opts("Indent Lines"))
keymap.set("v", "<S-Tab>", "<gv", opts("De-indent Lines"))
