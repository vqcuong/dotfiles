local status, flash = pcall(require, "flash")
if not status then
	return
end
flash.setup({
	search = {
		multi_window = true,
	},
	prompt = {
		prefix = { { "Teleport ⚡", "FlashPromptIcon" } },
	},
})
