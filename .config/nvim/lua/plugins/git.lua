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
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function opts(desc)
          return { buffer = buffer, desc = desc }
        end
        vim.keymap.set("n", "]h", gs.next_hunk, opts("Next hunk"))
        vim.keymap.set("n", "[h", gs.prev_hunk, opts("Prev hunk"))
        vim.keymap.set({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", opts("Stage hunk"))
        vim.keymap.set({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", opts("Reset hunk"))
        vim.keymap.set("n", "<leader>ghS", gs.stage_buffer, opts("Stage buffer"))
        vim.keymap.set("n", "<leader>ghu", gs.undo_stage_hunk, opts("Undo stage hunk"))
        vim.keymap.set("n", "<leader>ghR", gs.reset_buffer, opts("Reset buffer"))
        vim.keymap.set("n", "<leader>ghp", gs.preview_hunk, opts("Preview hunk"))
        vim.keymap.set("n", "<leader>ghb", function()
          gs.blame_line({ full = true })
        end, opts("Blame line"))
        vim.keymap.set("n", "<leader>ghd", gs.diffthis, opts("Diff this"))
        vim.keymap.set("n", "<leader>ghD", function()
          gs.diffthis("~")
        end, opts("Diff this ~"))
        vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", opts("GitSigns select hunk"))
      end,
    },
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      vim.keymap.set("n", "<leader>gdv", "<CMD>DiffviewOpen<CR>", { desc = "Diffview view" })
      vim.keymap.set("n", "<leader>gdx", "<CMD>DiffviewClose<CR>", { desc = "Diffview exit" })
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
      vim.keymap.set("n", "<leader>gnv", "<CMD>Neogit<CR>", { desc = "Neogit view" })
      vim.keymap.set("n", "<leader>gnx", "<CMD>lua require('neogit').close()<CR>", { desc = "Neogit exit" })
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
