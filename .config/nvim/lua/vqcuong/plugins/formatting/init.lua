return {
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"jay-babu/mason-null-ls.nvim",
		},
		config = function()
			local null_ls = require("null-ls")
			local mason_null_ls = require("mason-null-ls")
			mason_null_ls.setup({
				ensure_installed = {
					"ansible-lint",
					"jsonlint",
					"luacheck",
					"markdownlint",
					"ruff",
					"shellcheck",
					"yamllint",
					"hadolint",

					"beautysh",
					"black",
					"prettier",
					"stylua",
					"xmlformatter",
					"yamlfmt",
				},
				automatic_installation = true,
			})

			local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

			local lsp_formatting = function(bufnr)
				vim.lsp.buf.format({
					filter = function(client)
						-- use only null-ls for formatting (eg, not tsserver)
						return client.name == "null-ls"
					end,
					bufnr = bufnr,
				})
			end

			null_ls.setup({
				sources = {
					-- null_ls.builtins.diagnostics.ansiblelint,
					-- null_ls.builtins.diagnostics.jsonlint,
					-- null_ls.builtins.diagnostics.luacheck,
					-- null_ls.builtins.diagnostics.markdownlint,
					-- null_ls.builtins.diagnostics.ruff,
					-- null_ls.builtins.diagnostics.shellcheck,
					-- null_ls.builtins.diagnostics.yamllint,
					-- null_ls.builtins.diagnostics.hadolint,

					null_ls.builtins.formatting.beautysh.with({
						extra_args = { "--indent-size", "2" },
					}),
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.xmlformat,
					null_ls.builtins.formatting.yamlfmt,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						-- vim.api.nvim_create_autocmd("BufWritePre", {
						-- 	group = augroup,
						-- 	buffer = bufnr,
						-- 	callback = function()
						-- 		lsp_formatting(bufnr)
						-- 	end,
						-- })
					end
					local bufopts = { desc = "Format document", noremap = true, silent = true, buffer = bufnr }
					vim.keymap.set("n", "<leader>f", lsp_formatting, bufopts)
				end,
			})

			vim.api.nvim_create_user_command("DisableLspFormatting", function()
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
			end, { nargs = 0 })
		end,
	},
	-- {
	-- 	"stevearc/conform.nvim",
	-- 	config = function()
	-- 		local conform = require("conform")
	-- 		conform.setup({
	-- 			formatters_by_ft = {
	-- 				lua = { "stylua" },
	-- 				python = { "isort", "black" },
	-- 				javascript = { "prettier" },
	-- 			},
	-- 			format_on_save = {
	-- 				lsp_fallback = true,
	-- 				async = false,
	-- 				timeout_ms = 1000,
	-- 			},
	-- 		})
	--
	-- 		vim.keymap.set({ "n", "v" }, "<leader>F", function()
	-- 			conform.format({
	-- 				lsp_fallback = true,
	-- 				async = false,
	-- 				timeout_ms = 1000,
	-- 			})
	-- 		end, { desc = "Format File With Conform", noremap = true, silent = true })
	-- 	end,
	-- },
}
