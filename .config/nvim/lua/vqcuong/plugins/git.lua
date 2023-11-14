return {
	{
		"tpope/vim-fugitive",
		-- config = function()
		-- 	require("git").setup({
		-- 		keymaps = {
		-- 			blame = "<Leader>gb", -- Open blame window
		-- 			browse = "<Leader>go", -- Open file/folder in git repository
		-- 		},
		-- 	})
		-- end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"sindrets/diffview.nvim",
		config = function()
			vim.keymap.set("n", ";do", "<CMD>DiffviewOpen<CR>", { desc = "Git: Diffview Open" })
			vim.keymap.set("n", ";dx", "<CMD>DiffviewClose<CR>", { desc = "Git: Diffview Open" })
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
		config = function()
			vim.keymap.set("n", ";no", "<CMD>Neogit<CR>", { desc = "Git: Neogit Open" })
			vim.keymap.set("n", ";nx", "<CMD>lua require('neogit').close()<CR>", { desc = "Git: Neogit close" })
		end,
	},
	{
		"rbong/vim-flog",
		lazy = true,
		cmd = { "Flog", "Flogsplit", "Floggit" },
		dependencies = {
			"tpope/vim-fugitive",
		},
	},
	{
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
}
