return {
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		init = function()
			vim.opt.foldcolumn = "1"
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
			vim.opt.foldenable = true
		end,
		config = function()
			local ufo = require("ufo")
			local handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = (" 󰁂 %d "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end

			ufo.setup({ fold_virt_text_handler = handler })
			vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Folding: Open All" })
			vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Folding: Close All" })
		end,
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
		},
		init = function()
			-- vim.lsp.set_log_level("debug")
		end,
		config = function()
			local protocol = require("vim.lsp.protocol")
			local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
			local enable_format_on_save = function(_, bufnr)
				vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup_format,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ bufnr = bufnr })
					end,
				})
			end

			protocol.CompletionItemKind = {
				"", -- Text
				"", -- Method
				"", -- Function
				"", -- Constructor
				"", -- Field
				"", -- Variable
				"", -- Class
				"ﰮ", -- Interface
				"", -- Module
				"", -- Property
				"", -- Unit
				"", -- Value
				"", -- Enum
				"", -- Keyword
				"﬌", -- Snippet
				"", -- Color
				"", -- File
				"", -- Reference
				"", -- Folder
				"", -- EnumMember
				"", -- Constant
				"", -- Struct
				"", -- Event
				"ﬦ", -- Operator
				"", -- TypeParameter
			}

			-- Use an on_attach function to only map the following keys
			-- after the language server attaches to the current buffer
			local on_attach = function(client, bufnr)
				local function buf_set_keymap(...)
					vim.api.nvim_buf_set_keymap(bufnr, ...)
				end

				--Enable completion triggered by <c-x><c-o>
				--local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
				--buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

				-- Mappings.
				local opts = { noremap = true, silent = true }

				-- See `:help vim.lsp.*` for documentation on any of the below functions
				buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
				--buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
				buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
				--buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
			end

			-- Set up completion using nvim_cmp with LSP source
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- Enable folding
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			local mason_lspconfig = require("mason-lspconfig")

			local handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
					})
				end,
				["lua_ls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						on_attach = function(client, bufnr)
							on_attach(client, bufnr)
							-- enable_format_on_save(client, bufnr)
						end,
						settings = {
							Lua = {
								diagnostics = {
									-- Get the language server to recognize the `vim` global
									globals = { "vim" },
								},

								workspace = {
									-- Make the server aware of Neovim runtime files
									library = vim.api.nvim_get_runtime_file("", true),
									checkThirdParty = false,
								},
							},
						},
					})
				end,
			}

			mason_lspconfig.setup({
				ensure_installed = {
					"ansiblels",
					"bashls",
					"dockerls",
					"docker_compose_language_service",
					"jsonls",
					"lua_ls",
					"marksman",
					"pyright",
					"vimls",
					"yamlls",
				},
				automatic_installation = true,
				handlers = handlers,
			})

			-- nvim_lsp.lua_ls.setup({
			-- 	capabilities = capabilities,
			-- 	on_attach = function(client, bufnr)
			-- 		on_attach(client, bufnr)
			-- 		-- enable_format_on_save(client, bufnr)
			-- 	end,
			-- 	settings = {
			-- 		Lua = {
			-- 			diagnostics = {
			-- 				-- Get the language server to recognize the `vim` global
			-- 				globals = { "vim" },
			-- 			},
			--
			-- 			workspace = {
			-- 				-- Make the server aware of Neovim runtime files
			-- 				library = vim.api.nvim_get_runtime_file("", true),
			-- 				checkThirdParty = false,
			-- 			},
			-- 		},
			-- 	},
			-- })

			vim.lsp.handlers["textDocument/publishDiagnostics"] =
				vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
					underline = true,
					update_in_insert = false,
					virtual_text = { spacing = 4, prefix = "\u{ea71}" },
					severity_sort = true,
				})

			-- Diagnostic symbols in the sign column (gutter)
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
				},
				update_in_insert = true,
				float = {
					source = "always", -- Or "if_many"
				},
			})
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		dependencies = { "catppuccin/nvim" },
		config = function()
			local saga = require("lspsaga")
			saga.setup({
				ui = {
					kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
				},
				symbol_in_winbar = {
					enable = true,
					folder_level = 3,
				},
				code_action = {
					enable = true,
				},
				diagnostic = {
					show_code_action = true,
				},
				definition = {
					keys = {
						edit = "e",
						vsplit = "v",
						split = "h",
						tabe = "t",
						quit = "q",
						close = "q",
					},
				},
				finder = {
					keys = {
						vsplit = "v",
						split = "h",
						tabe = "t",
						tabnew = "r",
						quit = "q",
						close = "q",
					},
				},
				outline = {
					close_after_jump = true,
					keys = {
						jump = "j",
					},
				},
				rename = {
					keys = {
						quit = "q",
					},
				},
				lightbulb = {
					sign = false,
				},
			})

			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "<C-j>", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
			vim.keymap.set("n", "gl", "<Cmd>Lspsaga show_line_diagnostics<CR>", opts)
			vim.keymap.set("n", "gd", "<Cmd>Lspsaga hover_doc<CR>", opts)
			vim.keymap.set("n", "gf", "<Cmd>Lspsaga finder<CR>", opts)
			vim.keymap.set("n", "gt", "<Cmd>Lspsaga goto_type_definition<CR>", opts)
			-- vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
			vim.keymap.set("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
			vim.keymap.set("n", "gp", "<Cmd>Lspsaga peek_definition<CR>", opts)
			vim.keymap.set("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)
			vim.keymap.set({ "n", "v" }, "ga", "<cmd>Lspsaga code_action<CR>")
			vim.keymap.set({ "n", "v" }, "go", "<cmd>Lspsaga outline<CR>")
		end,
	},
}
