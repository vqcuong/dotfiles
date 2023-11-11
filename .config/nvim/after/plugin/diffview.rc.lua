local status, _ = pcall(require, "diffview")
if not status then
	return
end

vim.keymap.set("n", ";do", "<CMD>DiffviewOpen<CR>", { desc = "Git: Diffview Open" })
vim.keymap.set("n", ";dx", "<CMD>DiffviewClose<CR>", { desc = "Git: Diffview Open" })
