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

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
--
-- function nvim_create_augroups(definitions)
-- 	for group_name, definition in pairs(definitions) do
-- 		vim.api.nvim_command("augroup " .. group_name)
-- 		vim.api.nvim_command("autocmd!")
-- 		for _, def in ipairs(definition) do
-- 			local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
-- 			vim.api.nvim_command(command)
-- 		end
-- 		vim.api.nvim_command("augroup END")
-- 	end
-- end
--
-- local autoCommands = {
-- 	open_folds = {
-- 		{ "BufReadPost,FileReadPost", "*", "normal zR" },
-- 	},
-- }
--
-- nvim_create_augroups(autoCommands)
