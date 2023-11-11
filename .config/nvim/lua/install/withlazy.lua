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
	{ "akinsho/bufferline.nvim", version = "*" },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-path",
	"hrsh7th/nvim-cmp",
	{ "numToStr/Comment.nvim", lazy = false },
	"nvim-lualine/lualine.nvim",
	-- "feline-nvim/feline.nvim",
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
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"jay-babu/mason-null-ls.nvim",
	"nvimtools/none-ls.nvim", -- a replacement for null-ls which was archived on github
	-- "jose-elias-alvarez/null-ls.nvim",
	-- "stevearc/conform.nvim",
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{ "windwp/nvim-autopairs", event = "InsertEnter" },
	"norcalli/nvim-colorizer.lua",
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"windwp/nvim-ts-autotag",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
	},
	"nvim-treesitter/nvim-treesitter-context",
	{ "nvim-telescope/telescope.nvim", tag = "0.1.4" },
	"nvim-telescope/telescope-file-browser.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
	},
	"folke/zen-mode.nvim",
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
	},
	{
		"s1n7ax/nvim-window-picker",
		name = "window-picker",
		event = "VeryLazy",
		version = "2.*",
	},
	"goolord/alpha-nvim",
	"smjonas/inc-rename.nvim",
	"roobert/search-replace.nvim",
	"gelguy/wilder.nvim",
	"RRethy/vim-illuminate",
	{ "kylechui/nvim-surround", version = "*", event = "VeryLazy" },
	"levouh/tint.nvim",
	-- "terrortylor/nvim-comment",
	-- "rktjmp/lush.nvim",
	-- "ibhagwan/fzf-lua",
	-- {
	-- 	"nvimdev/dashboard-nvim",
	-- 	event = "VimEnter",
	-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- },
	-- "folke/trouble.nvim",
})
