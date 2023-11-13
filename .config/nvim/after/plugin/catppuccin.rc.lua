local status, catppuccin = pcall(require, "catppuccin")
if not status then
	return
end

catppuccin.setup({
	flavour = "mocha",
	background = {
		light = "mocha",
		dark = "mocha",
	},
	transparent_background = true,
	show_end_of_buffer = false,
	term_colors = false,
	dim_inactive = {
		enabled = false,
		shade = "dark",
		percentage = 0.4,
	},
	no_italic = false,
	no_bold = false,
	no_underline = false,
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},
	color_overrides = {
		mocha = {
			base = "#000000",
			text = "#fcf99f",
			lavender = "#e869ff",
			blue = "#00e5ff",
			rosewater = "#ff4763",
			red = "#ff478b",
			peach = "#ff8f85",
			mauve = "#ff308a",
			green = "#00fa47",
		},
	},
	custom_highlights = {},
	integrations = {
		cmp = true,
		flash = true,
		gitsigns = true,
		hop = true,
    lsp_saga = true,
		mason = true,
		noice = true,
		notify = true,
		nvimtree = true,
		overseer = true,
		treesitter = true,
		treesitter_context = true,
	},
})

vim.cmd.colorscheme("catppuccin")
