---@diagnostic disable: missing-fields

return {
  {
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
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.defaults["<leader>d"] = { name = "+lspsaga" }
    end,
  },

  {
    "nvimdev/lspsaga.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    opts = {
      symbol_in_winbar = {
        enable = true,
        folder_level = 2,
        color_mode = false,
      },
      code_action = {
        enable = true,
      },
      diagnostic = {
        show_code_action = true,
      },
      definition = {
        keys = {
          edit = "e",
          vsplit = "v",
          split = "h",
          tabe = "t",
          quit = "q",
          close = "q",
        },
      },
      finder = {
        keys = {
          vsplit = "v",
          split = "h",
          tabe = "t",
          tabnew = "n",
          quit = "q",
          close = "q",
        },
      },
      outline = {
        close_after_jump = true,
        keys = {
          jump = "e",
        },
      },
      rename = {
        keys = {
          quit = "q",
        },
      },
      lightbulb = {
        sign = false,
      },
    },
    keys = {
      { "<leader>d<right>", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Next diagnostic" },
      { "<leader>d<left>", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "Previous diagnostic" },
      { "<leader>dl", "<cmd>Lspsaga show_line_diagnostics<cr>", desc = "Line diagnostic" },
      { "<leader>df", "<cmd>Lspsaga finder<cr>", desc = "Finder" },
      { "<leader>dd", "<cmd>Lspsaga hover_doc<cr>", desc = "Docs" },
      { "<leader>dD", "<cmd>Lspsaga goto_type_definition<cr>", desc = "Goto type definition" },
      { "<leader>dp", "<cmd>Lspsaga peek_definition<cr>", desc = "Peek definition" },
      { "<leader>dP", "<cmd>Lspsaga peek_type_definition<cr>", desc = "Peek type definition" },
      { "<leader>dr", "<cmd>Lspsaga rename<cr>", desc = "Rename" },
      { "<leader>da", "<cmd>Lspsaga code_action<cr>", desc = "Code action" },
      { "<leader>do", "<cmd>Lspsaga outline<cr>", desc = "Outline" },

      { "<localleader>d", "<cmd>Lspsaga hover_doc<cr>", desc = "Docs" },
      { "<localleader>D", "<cmd>Lspsaga goto_type_definition<cr>", desc = "Goto type definition" },
      { "<localleader>p", "<cmd>Lspsaga peek_definition<cr>", desc = "Peek definition" },
      { "<localleader>P", "<cmd>Lspsaga peek_type_definition<cr>", desc = "Peek type definition" },
      { "<localleader>o", "<cmd>Lspsaga outline<cr>", desc = "Outline" },
      { "<localleader>r", "<cmd>Lspsaga rename<cr>", desc = "Rename" },
    },
  },

  {
    "onsails/lspkind.nvim",
    config = function()
      require("lspkind").init({
        mode = "symbol",
        preset = "codicons",
        symbol_map = {
          Text = "󰉿",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",
          Field = "󰜢",
          Variable = "",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "󰈇",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "",
        },
      })
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    keys = function()
      return {}
    end,
  },

  {
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
    -- stylua: ignore
    opts = function() return {} end,
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<c-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<c-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<c-b>"] = cmp.mapping.scroll_docs(-4),
          ["<c-f>"] = cmp.mapping.scroll_docs(4),
          ["<c-Space>"] = cmp.mapping.complete(),
          ["<c-e>"] = cmp.mapping.close(),
          ["<cr>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
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
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "emoji" },
        }, {
          { name = "buffer" },
        }, {
          { name = "codeium", group_index = 1, priority = 100 },
        }, {}),
        -- window = {
        --   completion = cmp.config.window.bordered({
        --     col_offset = -3,
        --     side_padding = 0,
        --   }),
        --   documentation = cmp.config.window.bordered(),
        -- },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            symbol_map = {
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
