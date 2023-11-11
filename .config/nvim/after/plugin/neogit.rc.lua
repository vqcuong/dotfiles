local status, _ = pcall(require, "neogit")
if not status then
	return
end

vim.keymap.set("n", ";no", "<CMD>Neogit<CR>", { desc = "Git: Neogit Open" })
vim.keymap.set("n", ";nx", "<CMD>lua require('neogit').close()<CR>", { desc = "Git: Neogit close" })
