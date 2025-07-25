return {
  {
    -- a terminal for nvim
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
        -- {
        --   "<c-t>",
        --   function()
        --     toggleterm.toggle(1, 10, dir, "horizontal", "helloworld")
        --   end,
        --   desc = "Terminal toggle",
        --   mode = { "n", "v", "t", "i" },
        -- },
      }
    end,
    opts = {
      close_on_exit = true,
    },
  },

  {
    -- markdown preview on browser
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
    -- has a function allowing to search and replace only in the current buffer
    -- but anothers seem to be useless or hard to use
    "roobert/search-replace.nvim",
    lazy = false,
    config = function()
      require("nvim-search-and-replace").setup({})
      require("which-key").add({
        { "<leader>r", group = "replace" },
        { "<leader>rr", "<cmd>SearchReplaceSingleBufferCWord<cr>", desc = "Replace text in current buffer" },
      })
    end,
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

  -- {
  --   -- an extensible UI for notifications and LSP progress messages
  --   "j-hui/fidget.nvim",
  --   event = "LspAttach",
  --   tag = "legacy",
  --   config = function()
  --     require("fidget").setup({
  --       text = {
  --         spinner = "meter",
  --       },
  --       window = {
  --         blend = 0,
  --       },
  --     })
  --   end,
  -- },

  {
    -- adding surround pairs for current word
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  {
    -- customizable windown picker writing by me
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

  -- {
  --   -- rick cursor movement animation
  --   "sphamba/smear-cursor.nvim",
  --   opts = {},
  -- },

  {
    -- automatically expand active window and more ...
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      -- unused due to the conflict with toggleterm
      -- "anuvyklack/animation.nvim",
    },
    config = function()
      vim.o.winwidth = 6
      vim.o.winminwidth = 5
      vim.o.equalalways = true

      require("windows").setup({
        autowidth = {
          enable = true,
        },
        ignore = {
          buftype = { "nofile", "temrinal" },
          filetype = {
            "NvimTree",
            "neo-tree",
            "undotree",
            "gundo",
            "toggleterm",
          },
        },
      })
      vim.api.nvim_set_keymap("n", "<localleader>m", "<cmd>WindowsMaximize<cr>", { noremap = true, silent = true })
    end,
  },

  {
    -- recognize the nearest pair with the current line
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
    -- for scrolling smoothly
    "karb94/neoscroll.nvim",
    config = function()
      local neoscroll = require("neoscroll")
      neoscroll.setup({
        mappings = { -- Keys to be mapped to their corresponding default scrolling animation
          "<C-d>",
          "<C-b>",
          "<C-f>",
          "<C-e>",
          "zt",
          "zz",
          "zb",
        },
      })
      local keymap = {
        ["<C-e>"] = function()
          neoscroll.ctrl_u({ duration = 240 })
        end,
        ["<C-d>"] = function()
          neoscroll.ctrl_d({ duration = 240 })
        end,
        -- Use the "circular" easing function
        ["<C-b>"] = function()
          neoscroll.ctrl_b({ duration = 400 })
        end,
        ["<C-f>"] = function()
          neoscroll.ctrl_f({ duration = 400 })
        end,
        ["<C-y>"] = function()
          -- neoscroll.scroll(-6, { move_cursor = false, duration = 250 })
        end,
        ["<C-u>"] = function()
          -- neoscroll.scroll(6, { move_cursor = false, duration = 250 })
        end,
      }
      local modes = { "n", "v", "x" }
      for key, func in pairs(keymap) do
        vim.keymap.set(modes, key, func)
      end
    end,
  },

  {
    -- beautiful folding code
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    lazy = false,
    init = function()
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
        desc = "Open All Folds",
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
      },
    },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
      for _, ls in ipairs(language_servers) do
        require("lspconfig")[ls].setup({
          capabilities = capabilities,
          -- you can add other fields for setting up lsp server in this table
        })
      end

      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" 󰁂 %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end
      require("ufo").setup({
        fold_virt_text_handler = handler,
      })
    end,
  },
}
