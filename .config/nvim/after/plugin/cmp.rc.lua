local status, cmp = pcall(require, "cmp")
if not status then
	return
end

vim.opt.pumheight = 20 

local lspkind = require("lspkind")

local function formatForTailwindCSS(entry, vim_item)
	if vim_item.kind == "Color" and entry.completion_item.documentation then
		local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
		if r then
			local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
			local group = "Tw_" .. color
			if vim.fn.hlID(group) < 1 then
				vim.api.nvim_set_hl(0, group, { fg = "#" .. color })
			end
			vim_item.kind = "●"
			vim_item.kind_hl_group = group
			return vim_item
		end
	end
	vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
	return vim_item
end

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "luasnip" },
		{ name = "path" },
	}),
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = lspkind.cmp_format({
			mode = "symbol_text",
			maxwidth = 50,
			before = function(entry, vim_item)
				vim_item.menu = "[" .. vim_item.kind .. "]"
				vim_item.dup = ({
					nvim_lsp = 0,
					path = 0,
				})[entry.source.name] or 0
				vim_item = formatForTailwindCSS(entry, vim_item)
				return vim_item
			end,
		}),
	},
})

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline({
		["<Up>"] = cmp.mapping({
			c = function(fallback)
				if cmp.visible() then
					return cmp.select_prev_item()
				end
				fallback()
			end,
		}),
		["<Down>"] = cmp.mapping({
			c = function(fallback)
				if cmp.visible() then
					return cmp.select_next_item()
				end
				fallback()
			end,
		}),
		["<Tab>"] = cmp.mapping({
			c = function()
				if cmp.visible() then
					return cmp.select_next_item()
				else
					cmp.complete()
					cmp.select_next_item()
					return
				end
			end,
		}),
		["<S-Tab>"] = cmp.mapping({
			c = function()
				if cmp.visible() then
					return cmp.select_prev_item()
				else
					cmp.complete()
					cmp.select_next_item()
					return
				end
			end,
		}),
	}),
	sources = {
		{ name = "buffer" },
	},
	formatting = {
		fields = { "abbr", "kind" },
		format = lspkind.cmp_format({
			mode = "symbol_text",
			maxwidth = 50,
			before = function(_, vim_item)
				if vim_item.kind == "Text" then
					vim_item.kind = ""
					return vim_item
				end
				vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
				return vim_item
			end,
		}),
	},
})

cmp.setup.cmdline(":", {
	completion = {
		autocomplete = false,
	},
	mapping = cmp.mapping.preset.cmdline({
		["<Up>"] = cmp.mapping({
			c = function(fallback)
				if cmp.visible() then
					return cmp.select_prev_item()
				end
				fallback()
			end,
		}),
		["<Down>"] = cmp.mapping({
			c = function(fallback)
				if cmp.visible() then
					return cmp.select_next_item()
				end
				fallback()
			end,
		}),
		["<Tab>"] = cmp.mapping({
			c = function()
				if cmp.visible() then
					return cmp.select_next_item()
				else
					cmp.complete()
					cmp.select_next_item()
					return
				end
			end,
		}),
		["<S-Tab>"] = cmp.mapping({
			c = function()
				if cmp.visible() then
					return cmp.select_prev_item()
				else
					cmp.complete()
					cmp.select_next_item()
					return
				end
			end,
		}),
	}),
	sources = {
		{ name = "path" },
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man", "!" },
			},
		},
	},
	formatting = {
		fields = { "abbr", "kind" },
		format = lspkind.cmp_format({
			mode = "symbol_text",
			maxwidth = 50,
			before = function(_, vim_item)
				if vim_item.kind == "Variable" then
					vim_item.kind = ""
					return vim_item
				end
				vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
				return vim_item
			end,
		}),
	},
})

vim.cmd([[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]])
