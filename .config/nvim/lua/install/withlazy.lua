local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"folke/which-key.nvim",
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	"folke/neodev.nvim",
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",
	"norcalli/nvim-colorizer.lua",
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
		},
	},
	"nvim-lualine/lualine.nvim",
	"numToStr/FTerm.nvim",
	"lewis6991/gitsigns.nvim",
	"tpope/vim-fugitive",
	"rbong/vim-flog",
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl" },
	"kdheepak/lazygit.nvim",
	"onsails/lspkind.nvim",
	"nvimdev/lspsaga.nvim",
	{ "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	"neovim/nvim-lspconfig",
	"nvimtools/none-ls.nvim", -- a replacement for jose-elias-alvarez/null-ls.nvim which was archived on github
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"jay-babu/mason-null-ls.nvim",
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
	},
	{ "windwp/nvim-autopairs", event = "InsertEnter" },
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"windwp/nvim-ts-autotag",
			"nvim-treesitter/nvim-treesitter-context",
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		dependencies = {
			"nvim-telescope/telescope-file-browser.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.opt.timeout = true
			vim.opt.timeoutlen = 300
		end,
	},
	"folke/zen-mode.nvim",
	"goolord/alpha-nvim",
	"smjonas/inc-rename.nvim",
	"roobert/search-replace.nvim",
	"HiPhish/rainbow-delimiters.nvim",
	"sindrets/diffview.nvim",
	"levouh/tint.nvim",
	{ "nvim-tree/nvim-tree.lua", version = "*", lazy = false },
	{ "s1n7ax/nvim-window-picker", name = "window-picker", event = "VeryLazy", version = "2.*" },
	{ "kylechui/nvim-surround", version = "*", event = "VeryLazy" },
	{ "Wansmer/treesj", dependencies = { "nvim-treesitter/nvim-treesitter" } },
	{ "phaazon/hop.nvim", event = "VeryLazy" },
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash Jump",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
		},
		config = function()
			require("flash").setup({
				modes = {
					char = {
						keys = { "s", "S" },
					},
				},
			})
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		init = function()
			vim.opt.foldcolumn = "1"
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
			vim.opt.foldenable = true
		end,
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"nvim-telescope/telescope.nvim", -- optional
			"sindrets/diffview.nvim", -- optional
			-- "ibhagwan/fzf-lua", -- optional
		},
		config = true,
	},
	{ "stevearc/overseer.nvim", opts = {} },
	{ "echasnovski/mini.animate", version = "*" },
	{ "echasnovski/mini.bracketed", version = "*" },
	{ "echasnovski/mini.comment", version = "*" },
	{ "echasnovski/mini.cursorword", version = "*" },
	{ "echasnovski/mini.move", version = "*" },
	-- { "echasnovski/mini.splitjoin", version = "*" },
	-- { "echasnovski/mini.indentscope", version = "*" },

	-- { "neoclide/coc.nvim", build = "npm ci" },
	-- { "akinsho/bufferline.nvim", version = "*" },
	-- { "airblade/vim-gitgutter", opts = {} },
	-- "j-hui/fidget.nvim",
	-- "gelguy/wilder.nvim",
	-- "ggandor/leap.nvim"
	-- "RRethy/vim-illuminate",
	-- "folke/todo-comments.nvim",
	-- "folke/trouble.nvim",
	-- "feline-nvim/feline.nvim",
	-- "stevearc/conform.nvim",
	-- "simrat39/symbols-outline.nvim"
	-- "stevearc/aerial.nvim"
	-- "terrortylor/nvim-comment",
	-- "rktjmp/lush.nvim",
	-- "ibhagwan/fzf-lua",
	-- {
	-- 	"nvimdev/dashboard-nvim",
	-- 	event = "VimEnter",
	-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- },
	-- {
	-- 	"numToStr/Comment.nvim",
	-- 	lazy = false,
	-- 	dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
	-- },
})
