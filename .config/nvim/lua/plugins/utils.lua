return {
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  { "folke/neodev.nvim" },
  { "stevearc/overseer.nvim", opts = {} },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        disable_filetype = { "TelescopePrompt", "vim" },
      })
    end,
  },
  -- {
  --   "echasnovski/mini.animate",
  --   version = "*",
  --   opts = {},
  -- },
  {
    "echasnovski/mini.bufremove",
    version = "*",
    keys = {
      {
        "<leader>bd",
        function()
          local bd = require("mini.bufremove").delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
            if choice == 1 then -- Yes
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then -- No
              bd(0, true)
            end
          else
            bd(0)
          end
        end,
        desc = "Delete Buffer",
      },
      -- stylua: ignore
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete buffer (force)" },
    },
  },
  {
    "echasnovski/mini.comment",
    version = "*",
    opts = {},
  },
  -- {
  --   "echasnovski/mini.cursorword",
  --   version = "*",
  --   opts = {},
  -- },
  -- {
  --   "echasnovski/mini.bracketed",
  --   version = "*",
  --   opts = {
  --     buffer = { suffix = "b", options = {} },
  --     comment = { suffix = "", options = {} },
  --     conflict = { suffix = "", options = {} },
  --     diagnostic = { suffix = "d", options = {} },
  --     file = { suffix = "f", options = {} },
  --     indent = { suffix = "", options = {} },
  --     jump = { suffix = "", options = {} },
  --     location = { suffix = "", options = {} },
  --     oldfile = { suffix = "o", options = {} },
  --     quickfix = { suffix = "", options = {} },
  --     treesitter = { suffix = "t", options = {} },
  --     undo = { suffix = "u", options = {} },
  --     window = { suffix = "w", options = {} },
  --     yank = { suffix = "", options = {} },
  --   },
  -- },
  {
    "numToStr/FTerm.nvim",
    config = function()
      local fterm = require("FTerm")

      fterm.setup({
        border = "single",
        auto_close = true,
        blend = 0,
        dimensions = {
          height = 0.6,
          width = 0.6,
          x = 0.5,
          y = 0.5,
        },
      })

      local function opts(desc)
        return { desc = "FTerm: " .. desc }
      end

      vim.keymap.set("n", "<leader>t", function()
        require("FTerm").toggle()
      end, opts("Toggle"))
      vim.keymap.set("t", "<leader>t", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts("Toggle"))
    end,
  },
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup({
        cmd_name = "IncRename",
        hl_group = "Substitute",
        preview_empty_name = false,
        show_message = false,
        post_hook = nil,
        input_buffer_type = "dressing",
      })
      -- vim.keymap.set("n", "<leader>e", ":IncRename ", {desc = "Rename"})
      vim.keymap.set("n", "<leader>e", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { desc = "Rename", expr = true })
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      local function opts(desc)
        return { desc = desc, silent = true }
      end
      vim.keymap.set("n", "md", "<CMD>MarkdownPreview<CR>", opts("Markdown Preview"))
    end,
  },
  {
    "roobert/search-replace.nvim",
    config = function()
      require("search-replace").setup({
        default_replace_single_buffer_options = "g",
        default_replace_multi_buffer_options = "g",
      })
      vim.keymap.set("n", "sr", "<CMD>SearchReplaceSingleBufferCWord<CR>", {
        desc = "Search And Replace",
      })
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.opt.timeout = true
      vim.opt.timeoutlen = 300
    end,
    opts = function()
      local o = {
        plugins = { spelling = true },
        defaults = {
          mode = { "n", "v" },
          ["g"] = { name = "+goto" },
          ["gs"] = { name = "+surround" },
          ["]"] = { name = "+next" },
          ["["] = { name = "+prev" },
          ["<leader><tab>"] = { name = "+tabs" },
          ["<leader>b"] = { name = "+buffer" },
          ["<leader>c"] = { name = "+code" },
          ["<leader>f"] = { name = "+file/find" },
          ["<leader>g"] = { name = "+git" },
          ["<leader>gh"] = { name = "+hunks" },
          ["<leader>l"] = { name = "+lsp" },
          ["<leader>q"] = { name = "+quit/session" },
          ["<leader>s"] = { name = "+search" },
          ["<leader>u"] = { name = "+ui" },
          ["<leader>w"] = { name = "+windows" },
          -- ["<leader>x"] = { name = "+diagnostics/quickfix" },
        },
      }
      if require("vqcuong.utils").has("noice.nvim") then
        o.defaults["<leader>n"] = { name = "+noice" }
      end
      return o
    end,
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    keys = {
      {
        "<leader>wp",
        function()
          local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
          vim.api.nvim_set_current_win(picked_window_id)
        end,
        desc = "pick a window",
      },
    },
    config = function()
      local picker = require("window-picker")
      picker.setup({
        hint = "floating-big-letter",
        selection_chars = "QWERASDFZXCVTYUIOPGHJKLBNM1234567890",
        show_prompt = false,
        filter_rules = {
          autoselect_one = true,
          include_current_win = true,
          bo = {
            filetype = {
              "NvimTree",
              "neo-tree",
              "neo-tree-popup",
              "notify",
              "packer",
              "qf",
              "diff",
              "fugitive",
              "fugitiveblame",
            },
            buftype = {
              "nofile",
              "terminal",
              -- "help",
            },
          },
        },
      })
    end,
  },
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup({})
      vim.keymap.set("n", "mz", "<CMD>ZenMode<CR>", { silent = true })
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = vim.opt.sessionoptions:get() },
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },

  -- {
  -- 	"numToStr/Comment.nvim",
  -- 	lazy = false,
  -- 	dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
  -- 	config = function()
  -- 		require("Comment").setup({
  -- 			pre_hook = function(ctx)
  -- 				-- Only calculate commentstring for tsx filetypes
  -- 				if vim.bo.filetype == "typescriptreact" then
  -- 					local U = require("Comment.utils")
  -- 					-- Determine whether to use linewise or blockwise commentstring
  -- 					local type = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"
  -- 					-- Determine the location where to calculate commentstring from
  -- 					local location = nil
  -- 					if ctx.ctype == U.ctype.blockwise then
  -- 						location = require("ts_context_commentstring.utils").get_cursor_location()
  -- 					elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
  -- 						location = require("ts_context_commentstring.utils").get_visual_start_location()
  -- 					end
  -- 					return require("ts_context_commentstring.internal").calculate_commentstring({
  -- 						key = type,
  -- 						location = location,
  -- 					})
  -- 				end
  -- 			end,
  -- 		})
  -- 	end,
  -- },
}
