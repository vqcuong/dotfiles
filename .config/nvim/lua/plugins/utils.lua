return {
  { "stevearc/overseer.nvim", opts = {} },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = function()
      local dir = vim.fn.getcwd()
      local toggleterm = require("toggleterm")
      return {
        {
          "<localleader>/",
          function()
            toggleterm.toggle(1, 10, dir, "horizontal", "helloworld")
          end,
          desc = "Terminal toggle",
          mode = { "n", "v", "t" },
        },
        {
          "<c-t>",
          function()
            toggleterm.toggle(1, 10, dir, "horizontal", "helloworld")
          end,
          desc = "Terminal toggle",
          mode = { "n", "v", "t" },
        },
      }
    end,
    opts = {
      close_on_exit = true,
    },
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    keys = function()
      -- stylua: ignore
      return {
        { "md", "<cmd>MarkdownPreview<cr>", desc = "Markdown preview" }
      }
    end,
  },

  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.defaults["<leader>r"] = { name = "+replace" }
    end,
  },

  {
    -- has a function allowing to search and replace only in the current buffer
    -- but anothers seem to be useless or hard to use
    "roobert/search-replace.nvim",
    lazy = false,
    keys = {
      { "<leader>rr", "<cmd>SearchReplaceSingleBufferCWord<cr>", desc = "Replace text in current buffer" },
    },
    config = true,
  },

  {
    -- have some functions for searching and replacing in the whole workdir
    "s1n7ax/nvim-search-and-replace",
    config = function()
      require("nvim-search-and-replace").setup({
        ignore = { "**/node_modules/**", "**/.git/**", "**/.gitignore", "**/.gitmodules", "build/**" },
        -- save the changes after replace
        update_changes = false,
        -- keymap for search and replace
        replace_keymap = "<leader>rs",
        -- keymap for search and replace ( this does not care about ignored files )
        replace_all_keymap = "<leader>rS",
        -- keymap for search and replace
        replace_and_save_keymap = "<leader>ru",
        -- keymap for search and replace ( this does not care about ignored files )
        replace_all_and_save_keymap = "<leader>rU",
      })
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  {
    "vqcuong/window-picker.nvim",
    name = "window-picker",
    event = "VeryLazy",
    version = false,
    keys = {
      {
        "<localleader>w",
        function()
          local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
          vim.api.nvim_set_current_win(picked_window_id)
        end,
        desc = "pick a window",
        mode = { "n", "v", "t" },
      },
    },
    config = function()
      local picker = require("window-picker")
      picker.setup({
        hint = "floating-big-letter",
        selection_chars = "QWEASDZXCRTYFGHVBN123456",
        show_prompt = false,
        filter = {
          filter_func = function(winids)
            local never_pick_filetypes = {
              "neo-tree-popup",
              "notify",
              "packer",
              "qf",
              "diff",
              "fugitive",
              "fugitiveblame",
              "noice",
            }
            local buf_win_map = {}
            local terminal_bufids = {}
            local file_bufids = {}
            local menu_bufids = {}

            for _, winid in pairs(winids) do
              if vim.api.nvim_win_get_config(winid).focusable then
                local bufid = vim.api.nvim_win_get_buf(winid)
                local buf = vim.bo[bufid]
                if vim.tbl_contains({ "NvimTree", "neo-tree" }, buf.ft) then
                  table.insert(menu_bufids, bufid)
                elseif buf.ft == "toggleterm" then
                  table.insert(terminal_bufids, bufid)
                elseif not vim.tbl_contains(never_pick_filetypes, buf.ft) and buf.bt ~= "nofile" then
                  table.insert(file_bufids, bufid)
                end
                buf_win_map[bufid] = winid
              end
            end

            local pickable_winids = {}
            local function fact(list)
              local rs = {}
              for _, bufid in pairs(list) do
                if bufid ~= vim.api.nvim_get_current_buf() then
                  table.insert(rs, buf_win_map[bufid])
                end
              end
              return rs
            end

            local file_winids = fact(file_bufids)
            local menu_winids = fact(menu_bufids)
            local terminal_winids = fact(terminal_bufids)
            if #file_winids > 0 then
              pickable_winids = file_winids
            else
              -- stylua: ignore
              for _, v in pairs(menu_winids) do table.insert(pickable_winids, v) end
              -- stylua: ignore
              for _, v in pairs(terminal_winids) do table.insert(pickable_winids, v) end
            end

            if #pickable_winids == 0 then
              return { vim.api.nvim_get_current_win() }
            end
            return pickable_winids
          end,
          -- excluded = {
          --   buffer_opts = {
          --     filetype = {
          --       "NvimTree",
          --       "neo-tree",
          --       "neo-tree-popup",
          --       "notify",
          --       "packer",
          --       "qf",
          --       "diff",
          --       "fugitive",
          --       "fugitiveblame",
          --     },
          --     buftype = {
          --       "nofile",
          --       -- "terminal",
          --       -- "help",
          --     },
          --   },
          -- },
        },
      })
    end,
  },

  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        backdrop = 1,
      },
      plugins = {
        twilight = { enabled = false },
        gitsigns = { enabled = true },
        tmux = { enabled = true },
        kitty = { enabled = false, font = "+4" },
        alacritty = { enabled = true, font = "+4" },
        wezterm = { enabled = false, font = "+4" },
      },
    },
    keys = {
      { "<localleader>Z", "<cmd>ZenMode<cr>", silent = true, desc = "Zen mode" },
    },
    config = true,
  },

  {
    "declancm/maximize.nvim",
    opts = {
      default_keymaps = false,
    },
    keys = {
      {
        "<localleader>z",
        function()
          require("maximize").toggle()
        end,
        desc = "Maximize window",
        mode = { "n", "v" },
      },
    },
  },

  {
    "numToStr/Navigator.nvim",
    config = true,
    keys = {
      { "<m-left>", "<cmd>NavigatorLeft<cr>", desc = "Go left", mode = { "n", "t" } },
      { "<m-right>", "<cmd>NavigatorRight<cr>", desc = "Go right", mode = { "n", "t" } },
      { "<m-up>", "<cmd>NavigatorUp<cr>", desc = "Go up", mode = { "n", "t" } },
      { "<m-down>", "<cmd>NavigatorDown<cr>", desc = "Go down", mode = { "n", "t" } },
      { "<m-.>", "<cmd>NavigatorPrevious<cr>", desc = "Go previous", mode = { "n", "t" } },
    },
  },

  {
    "utilyre/sentiment.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {},
    init = function()
      -- `matchparen.vim` needs to be disabled manually in case of lazy loading
      vim.g.loaded_matchparen = 1
    end,
  },

  {
    "karb94/neoscroll.nvim",
    config = true,
  },
}
