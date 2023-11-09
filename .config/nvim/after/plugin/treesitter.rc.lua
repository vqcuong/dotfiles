local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

ts.setup({
	highlight = {
		enable = true,
		disable = {},
	},
	indent = {
		enable = true,
		disable = {},
	},
	ensure_installed = {
    "bash",
    "css",
    "dockerfile",
		"fish",
    "go",
    "gomod",
		"html",
		"json",
    "lua",
		"markdown",
		"markdown_inline",
    "python",
    "sql",
		"toml",
    "xml",
		"yaml",
	},
	autotag = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
