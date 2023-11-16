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
  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
      require("mini.animate").setup()
      require("mini.bracketed").setup({
        buffer = { suffix = "b", options = {} },
        comment = { suffix = "", options = {} },
        conflict = { suffix = "", options = {} },
        diagnostic = { suffix = "d", options = {} },
        file = { suffix = "f", options = {} },
        indent = { suffix = "", options = {} },
        jump = { suffix = "", options = {} },
        location = { suffix = "", options = {} },
        oldfile = { suffix = "o", options = {} },
        quickfix = { suffix = "", options = {} },
        treesitter = { suffix = "t", options = {} },
        undo = { suffix = "u", options = {} },
        window = { suffix = "w", options = {} },
        yank = { suffix = "", options = {} },
      })
      require("mini.comment").setup()
      require("mini.cursorword").setup()
      require("mini.move").setup({
        mappings = {
          left = "<C-h>",
          right = "<C-l>",
          -- down = "<C-j>",
          -- up = "<C-k>",

          line_left = "<C-h>",
          line_right = "<C-l>",
          -- line_down = "<C-j>",
          -- line_up = "<C-k>",
        },
      })
      -- require("mini.indentscope").setup({
      --   symbol = "▏",
      -- })
    end,
  },

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
    config = function()
      require("which-key").setup({})
    end,
  },
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
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
      vim.keymap.set("n", "\\w", function()
        local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(picked_window_id)
      end, { desc = "Pick a window" })
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
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      local rd = require("rainbow-delimiters")
      require("rainbow-delimiters.setup").setup({
        strategy = {
          [""] = rd.strategy["global"],
          vim = rd.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "rainbowdelimiterred",
          "rainbowdelimiteryellow",
          "rainbowdelimiterblue",
          "rainbowdelimiterorange",
          "rainbowdelimitergreen",
          "rainbowdelimiterviolet",
          "RainbowDelimiterCyan",
        },
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      local ibl = require("ibl")
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#6b484a" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#80673b" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#1f5b61" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#1c5909" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#0e103b" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#3b0e3a" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#0e4d54" })
      end)

      ibl.setup({
        indent = { char = "▏", highlight = highlight },
        whitespace = {
          highlight = highlight,
          remove_blankline_trail = false,
        },
        scope = { highlight = highlight },
      })
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
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
