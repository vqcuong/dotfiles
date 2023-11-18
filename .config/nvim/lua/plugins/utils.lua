return {
  { "stevearc/overseer.nvim", opts = {} },

  {
    "numToStr/FTerm.nvim",
    -- stylua: ignore
    keys = {
      { "<localleader>t", function() require("FTerm").toggle() end, desc = "Float terminal toggle", mode = { "n", "t", "v" } },
      { "<esc><esc>", function () require("FTerm").toggle()  end, silent = true, mode = {"t"} }
    },
    opts = {
      border = "single",
      auto_close = true,
      blend = 0,
      dimensions = {
        height = 0.6,
        width = 0.6,
        x = 0.5,
        y = 0.5,
      },
    },
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = function()
      local dir = vim.fn.getcwd()
      local toggleterm = require("toggleterm")
      return {
        {
          "<localleader><localleader>",
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
    "smjonas/inc-rename.nvim",
    keys = {
      {
        "<localleader>e",
        function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end,
        desc = "Rename",
      },
      -- {
      --   "<leader>e",
      --   function()
      --     return ":IncRename "
      --   end,
      --   desc = "Rename",
      -- },
    },
    opts = {
      cmd_name = "IncRename",
      hl_group = "Substitute",
      preview_empty_name = false,
      show_message = false,
      post_hook = nil,
      input_buffer_type = "dressing",
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
    config = function()
      local function opts(desc)
        return { desc = desc, silent = true }
      end
    end,
  },
  {
    "roobert/search-replace.nvim",
    keys = {
      { "sr", "<cmd>SearchReplaceSingleBufferCWord<cr>", desc = "Search and replace" },
    },
    opts = {
      default_replace_single_buffer_options = "g",
      default_replace_multi_buffer_options = "g",
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    keys = {
      {
        "<localleader>w",
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
    keys = {
      { "<leader>zm", "<cmd>ZenMode<cr>", silent = true, desc = "Zen mode" },
    },
  },
}
