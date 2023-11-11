local status, git = pcall(require, "git")
if not status then
	return
end

git.setup({
	keymaps = {
		-- Open blame window
		blame = "<Leader>gb",
		-- Open file/folder in git repository
		browse = "<Leader>go",
	},
})

local status1, _ = pcall(require, "diffview")
if not status1 then
	return
end

vim.keymap.set("n", ";do", "<CMD>DiffviewOpen<CR>", { desc = "Git: Diffview Open" })
vim.keymap.set("n", ";dx", "<CMD>DiffviewClose<CR>", { desc = "Git: Diffview Open" })

local status2, _ = pcall(require, "neogit")
if not status2 then
	return
end

vim.keymap.set("n", ";dx", "<CMD>Neogit<CR>", { desc = "Git: Neogit Open" })
vim.keymap.set("n", ";dx", "<CMD>lua require('neogit').close()<CR>", { desc = "Git: Neogit close" })

local status3, gitsigns = pcall(require, "gitsigns")
if not status3 then
	return
end

gitsigns.setup()
