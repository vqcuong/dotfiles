require("mini.animate").setup()
require("mini.bracketed").setup()
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
require("mini.splitjoin").setup()
