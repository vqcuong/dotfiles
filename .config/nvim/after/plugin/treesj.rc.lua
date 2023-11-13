local status, treesj = pcall(require, "treesj")
if not status then
	return
end

treesj.setup({
	use_default_keymaps = false,
	check_syntax_error = true,
	max_join_length = 120,
	cursor_behavior = "hold",
	notify = true,
	dot_repeat = true,
	on_error = nil,
})

vim.keymap.set("n", "gS", function()
	treesj.toggle({ split = { recursive = true } })
end, { desc = "SplitJoin: Toggle" })
