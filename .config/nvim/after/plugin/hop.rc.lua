local status, hop = pcall(require, "hop")
if not status then
	return
end

local directions = require("hop.hint").HintDirection
local positions = require("hop.hint").HintPosition

hop.setup({
	hint_position = positions.END,
})

vim.keymap.set("", "f", function()
	hop.hint_char1()
end, { remap = true })
vim.keymap.set("", "F", function()
	hop.hint_char2()
end, { remap = true })
vim.keymap.set("", "t", function()
	hop.hint_char1({
		direction = directions.AFTER_CURSOR,
	})
end, { remap = true })
vim.keymap.set("", "T", function()
	hop.hint_char1({
		direction = directions.BEFORE_CURSOR,
	})
end, { remap = true })
vim.keymap.set("", "L", function()
	hop.hint_lines_skip_whitespace()
end, { remap = true })
vim.keymap.set("", "P", function()
	hop.hint_patterns()
end, { remap = true })
