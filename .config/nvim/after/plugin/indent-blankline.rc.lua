local status, ibl = pcall(require, "ibl")
if not status then
	return
end

local highlight = {
	"RainbowRed",
	"RainbowYellow",
	"RainbowBlue",
	"RainbowOrange",
	"RainbowGreen",
	"RainbowViolet",
	"RainbowCyan",
}

local hooks = require("ibl.hooks")
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#914c51" })
	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#a18550" })
	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#4c8dc2" })
	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#b5875c" })
	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#819e6c" })
	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#956fa1" })
	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#6eb1ba" })
end)

vim.g.rainbow_delimiters = { highlight = highlight }
ibl.setup({
	indent = { char = "▏", highlight = highlight },
	whitespace = {
		highlight = highlight,
		remove_blankline_trail = false,
	},
	scope = { highlight = highlight },
})
hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
