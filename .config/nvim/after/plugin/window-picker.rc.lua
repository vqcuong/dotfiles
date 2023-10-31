local status, picker = pcall(require, "window-picker")
if not status then
	return
end

picker.setup({
	hint = "floating-big-letter",
	selection_chars = "QWERASDFZXCVTYUIOPGHJKLBNM1234567890",
	show_prompt = false,
	filter_rules = {
		autoselect_one = true,
		include_current_win = true,
		bo = {
			filetype = {
				"NvimTree",
				"neo-tree",
				"neo-tree-popup",
				"notify",
				"packer",
				"qf",
				"diff",
				"fugitive",
				"fugitiveblame",
			},
			buftype = {
				"nofile",
				"terminal",
				"help",
			},
		},
	},
})

vim.keymap.set("n", "\\w", function()
	local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
	vim.api.nvim_set_current_win(picked_window_id)
end, { desc = "Pick a window" })
