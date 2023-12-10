return {
  { "stevearc/overseer.nvim", opts = {} },

  -- {
  --   "numToStr/FTerm.nvim",
  --   -- stylua: ignore
  --   keys = {
  --     { "<localleader>T", function() require("FTerm").toggle() end, desc = "Float terminal toggle", mode = { "n", "t", "v" } },
  --     { "<esc><esc>", function () require("FTerm").toggle()  end, silent = true, mode = {"t"} }
  --   },
  --   opts = {
  --     border = "single",
  --     auto_close = true,
  --     blend = 0,
  --     dimensions = {
  --       height = 0.6,
  --       width = 0.6,
  --       x = 0.5,
  --       y = 0.5,
  --     },
  --   },
  -- },

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
}
