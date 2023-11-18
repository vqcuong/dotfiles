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
        mode = { "n", "v", "t" },
      },
    },
    config = function()
      local picker = require("window-picker")
      picker.setup({
        hint = "floating-big-letter",
        selection_chars = "QWERASDFZXCVTYUIOPGHJKLBNM1234567890",
        show_prompt = false,
        filter_func = function(winids, _)
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
          -- stylua: ignore
          local function contains(l, e) for _, v in pairs(l) do if v == e then return true end end return false end

          for winid in pairs(winids) do
            if vim.api.nvim_win_get_config(winid).focusable == true then
              local bufid = vim.api.nvim_win_get_buf(winid)
              local buf = vim.bo[bufid]
              if contains({ "NvimTree", "neo-tree" }, buf.filetype) then
                table.insert(menu_bufids, bufid)
              elseif not contains(never_pick_filetypes, buf.filetype) then
                if buf.buftype ~= "nofile" then
                  table.insert(file_bufids, bufid)
                end
              elseif buf.filetype == "toggleterm" then
                table.insert(terminal_bufids, bufid)
              end
              buf_win_map[bufid] = winid
            end
          end

          local pickable_winids = {}
          local curr_bufid = vim.api.nvim_get_current_buf()
          local function fact(list)
            for bufid in pairs(list) do
              if bufid ~= curr_bufid then
                table.insert(pickable_winids, buf_win_map[bufid])
              end
            end
          end

          if next(file_bufids) == nil then
            fact(menu_bufids)
            fact(terminal_bufids)
          else
            fact(file_bufids)
          end
          return pickable_winids
        end,
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
              -- "terminal",
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
