local lazyvimUtil = require("lazyvim.util")
local lazyvimConfig = require("lazyvim.config")

return {
  {
    -- toggle rewriting a code scope in a single line
    "Wansmer/treesj",
    keys = {
      {
        "as",
        function()
          require("treesj").toggle({ split = { recursive = true } })
        end,
        desc = "Split-join toggle",
      },
    },
    opts = {
      use_default_keymaps = false,
      check_syntax_error = true,
      max_join_length = 120,
      cursor_behavior = "hold",
      notify = true,
      dot_repeat = true,
      on_error = nil,
    },
  },

  {
    -- snippet engine
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    keys = function()
      return {}
    end,
  },

  {
    -- quickly jump to any place in the file
    "folke/flash.nvim",
    keys = function()
      -- stylua: ignore
      return {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" }
      }
    end,
  },

  {
    -- quickly jump to any place in the file
    "phaazon/hop.nvim",
    event = "VeryLazy",
    -- stylua: ignore
    keys = {
      -- { "f", function() require("hop").hint_char1() end, remap = true },
      -- { "F", function() require("hop").hint_char2() end, remap = true },
      { "A", function() require("hop").hint_lines_skip_whitespace() end, remap = true },
      { "P", function() require("hop").hint_patterns() end, remap = true },
    },
    config = function()
      local positions = require("hop.hint").HintPosition
      require("hop").setup({ hint_position = positions.END })
    end,
  },

  {
    -- diagnose the issues
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<localleader>x", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<localleader>X", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
    },
  },

  {
    -- highlight the comment and quickly jump to it by pre-configured keywords
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- stylua: ignore
    keys = {
      { "<localleader>t", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      { "<localleader>T", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
    },
    opts = {
      highlight = {
        pattern = [[.*<(KEYWORDS)\s*]],
      },
      search = {
        pattern = [[.*<(KEYWORDS)\s*]],
      },
    },
  },

  {
    -- highlight the same words in a file
    "sontungexpt/stcursorword",
    event = "VeryLazy",
    opts = {
      highlight = {
        underline = false,
        bg = "#44515e",
      },
    },
    config = true,
  },

  {
    -- quickly search text, tab, ... in the current buffer or the whole project
    "ibhagwan/fzf-lua",
    init = function()
      vim.ui.select = nil
    end,
    opts = {
      winopts = {
        height = 1,
        width = 0.35,
        row = 0.5,
        col = 1,
        border = false,
        layout = "horizontal",
        preview = {
          border = "noborder",
          wrap = "wrap",
          title = false,
          scrollbar = false,
          vertical = "down:70%",
        },
      },
      ui_select = nil,
    },
    keys = function()
      require("which-key").add({
        { "<leader>h", group = "helps" },
        { "<leader>ha", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
        { "<leader>hc", "<cmd>FzfLua commands<cr>", desc = "Commands" },
        { "<leader>hC", LazyVim.pick("colorschemes"), desc = "Colorscheme with Preview" },
        { "<leader>hh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
        { "<leader>hl", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
        { "<leader>hk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
        { "<leader>hm", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
      })

      return {
        { "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
        { "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },

        -- find
        { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
        { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
        { "<leader>ff", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
        { "<leader>fF", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
        { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
        { "<leader>fR", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
        -- git
        { "<leader>gf", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
        { "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Commits" },
        { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Status" },
        -- search
        { "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer" },
        { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
        { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
        { "<leader>sg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
        { "<leader>sG", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
        { "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
        { "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
        { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
        { "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
        { "<leader>sw", LazyVim.pick("grep_cword"), desc = "Word (Root Dir)" },
        { "<leader>sW", LazyVim.pick("grep_cword", { root = false }), desc = "Word (cwd)" },
        { "<leader>sw", LazyVim.pick("grep_visual"), mode = "v", desc = "Selection (Root Dir)" },
        { "<leader>sW", LazyVim.pick("grep_visual", { root = false }), mode = "v", desc = "Selection (cwd)" },
        { "<leader>o", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Goto Symbol" },
        { "<leader>O", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", desc = "Goto Symbol (Workspace)" },

        -- stylua: ignored
        { "<leader>.", "<cmd>FzfLua resume<cr>", desc = "Resume" },
        { "<leader>'", "<cmd>FzfLua registers<cr>", desc = "Registers" },
        { "<leader>,", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Switch Buffer" },
        { "<leader>/", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
        { "<leader>G", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
        { "<leader>;", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
        { "<leader><space>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      }
    end,
  },

  {
    -- configurable auto-suggestion and auto-completion
    "hrsh7th/nvim-cmp",
    lazy = false,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
    },
    init = function()
      vim.opt.pumheight = 20
    end,
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      {
        "<tab>",
        function()
          require("luasnip").jump(1)
        end,
        mode = "s",
      },
      {
        "<s-tab>",
        function()
          require("luasnip").jump(-1)
        end,
        mode = { "i", "s" },
      },
    },
    -- stylua: ignore
    opts = function() return {} end,
    config = function()
      local cmp = require("cmp")
      local auto_select = true
      local defaults = require("cmp.config.default")()
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      cmp.setup({
        auto_brackets = { "python" },
        completion = {
          completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
        },
        preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
        -- snippet = {
        --   expand = function(args)
        --     luasnip.lsp_expand(args.body)
        --   end,
        -- },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        mapping = cmp.mapping.preset.insert({
          ["<c-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<c-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<c-b>"] = cmp.mapping.scroll_docs(-4),
          ["<c-f>"] = cmp.mapping.scroll_docs(4),
          ["<c-space>"] = cmp.mapping.complete(),
          ["<c-e>"] = cmp.mapping.close(),
          ["<cr>"] = LazyVim.cmp.confirm({ select = auto_select }),
          ["<c-cr>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({}, {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "emoji" },
          -- { name = "copilot" },
          { name = "codeium" },
        }, {
          { name = "buffer" },
        }, {
          { name = "lazydev", group_index = 0 },
        }, {}),
        window = {
          -- completion = cmp.config.window.bordered({
          --   leading_offset = 0,
          --   col_offset = -3,
          --   side_padding = 0,
          -- }),
          documentation = cmp.config.window.bordered({
            col_offset = -3,
          }),
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            symbol_map = {
              -- Copilot = " ",
              Codeium = "",
            },
            before = function(entry, vim_item)
              vim_item.menu = "[" .. vim_item.kind .. "]"
              vim_item.dup = ({
                nvim_lsp = 0,
                path = 0,
              })[entry.source.name] or 0
              vim_item.kind = lspkind.symbolic(vim_item.kind) or vim_item.kind
              return vim_item
            end,
          }),
        },
        sorting = defaults.sorting,
      })

      local cmdline_mapping = {
        ["<Up>"] = cmp.mapping({
          c = function(fallback)
            if cmp.visible() then
              return cmp.select_prev_item()
            end
            fallback()
          end,
        }),
        ["<Down>"] = cmp.mapping({
          c = function(fallback)
            if cmp.visible() then
              return cmp.select_next_item()
            end
            fallback()
          end,
        }),
        ["<Tab>"] = cmp.mapping({
          c = function()
            if cmp.visible() then
              return cmp.select_next_item()
            else
              cmp.complete()
              cmp.select_next_item()
              return
            end
          end,
        }),
        ["<S-Tab>"] = cmp.mapping({
          c = function()
            if cmp.visible() then
              return cmp.select_prev_item()
            else
              cmp.complete()
              cmp.select_next_item()
              return
            end
          end,
        }),
      }

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(cmdline_mapping),
        sources = { { name = "buffer" } },
        formatting = {
          fields = { "abbr", "kind" },
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            before = function(_, vim_item)
              if vim_item.kind == "Text" then
                -- vim_item.kind = ""
                vim_item.kind = "🔍"
                return vim_item
              end
              vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
              return vim_item
            end,
          }),
        },
      })

      cmp.setup.cmdline(":", {
        completion = { autocomplete = false },
        mapping = cmp.mapping.preset.cmdline(cmdline_mapping),
        sources = {
          { name = "path" },
          { name = "cmdline", option = { ignore_cmds = { "Man", "!" } } },
        },
        formatting = {
          fields = { "abbr", "kind" },
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            before = function(_, vim_item)
              if vim_item.kind == "Variable" then
                vim_item.kind = ""
                return vim_item
              end
              vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
              return vim_item
            end,
          }),
        },
      })

      vim.cmd([[
        highlight! default link CmpItemKind CmpItemMenuDefault
      ]])
    end,
  },
}
