-- local status, conform = pcall(require, "conform")
-- if not status then
-- 	return
-- end
--
-- conform.setup({
-- 	formatters_by_ft = {
-- 		lua = { "stylua" },
-- 		python = { "isort", "black" },
-- 		javascript = { "prettier" },
-- 	},
-- 	format_on_save = {
-- 		lsp_fallback = true,
-- 		async = false,
-- 		timeout_ms = 1000,
-- 	},
-- })
--
-- vim.keymap.set({ "n", "v" }, "<leader>F", function()
-- 	conform.format({
-- 		lsp_fallback = true,
-- 		async = false,
-- 		timeout_ms = 1000,
-- 	})
-- end, { desc = "Format File With Conform", noremap = true, silent = true })
