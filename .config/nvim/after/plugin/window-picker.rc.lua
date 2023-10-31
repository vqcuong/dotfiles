local status, picker = pcall(require, "window-picker")
if not status then
	return
end

vim.keymap.set("n", "\\w", function()
	local picked_window_id = picker.pick_window({
		include_current_win = true,
		hint = "floating-big-letter",
		show_prompt = false,
	}) or vim.api.nvim_get_current_win()
	vim.api.nvim_set_current_win(picked_window_id)
end, { desc = "Pick a window" })
