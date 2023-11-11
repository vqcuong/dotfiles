local status, notify = pcall(require, "notify")
if not status then
	return
end

notify.setup({
	background_colour = "#000000",
})

vim.keymap.set("n", "nx", function()
	notify.dismiss({ pending = true, silent = true })
end, {desc = "Clear Notifications"})
