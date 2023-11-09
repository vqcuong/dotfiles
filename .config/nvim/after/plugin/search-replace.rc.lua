local status, sr = pcall(require, "search-replace")
if not status then
	return
end

sr.setup({
	default_replace_single_buffer_options = "g",
	default_replace_multi_buffer_options = "g",
})

vim.keymap.set("n", "sr", "<CMD>SearchReplaceSingleBufferCWord<CR>", { desc = "Search And Replace" })
