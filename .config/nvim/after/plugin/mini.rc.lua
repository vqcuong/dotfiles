require("mini.animate").setup()
require("mini.bracketed").setup({
	buffer = { suffix = "b", options = {} },
	comment = { suffix = "", options = {} },
	conflict = { suffix = "", options = {} },
	diagnostic = { suffix = "d", options = {} },
	file = { suffix = "f", options = {} },
	indent = { suffix = "", options = {} },
	jump = { suffix = "", options = {} },
	location = { suffix = "", options = {} },
	oldfile = { suffix = "o", options = {} },
	quickfix = { suffix = "", options = {} },
	treesitter = { suffix = "t", options = {} },
	undo = { suffix = "u", options = {} },
	window = { suffix = "w", options = {} },
	yank = { suffix = "", options = {} },
})
require("mini.comment").setup()
require("mini.cursorword").setup()
-- require("mini.indentscope").setup({
-- 	symbol = "▏",
-- })
require("mini.move").setup({
	mappings = {
		-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
		left = "<C-h>",
		right = "<C-l>",
		down = "<C-j>",
		up = "<C-k>",

		-- Move current line in Normal mode
		line_left = "<C-h>",
		line_right = "<C-l>",
		line_down = "<C-j>",
		line_up = "<C-k>",
	},
})
