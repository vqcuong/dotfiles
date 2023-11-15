local default_config_dir = vim.fn.stdpath("config") .. "/lua/vqcuong/plugins/formatting/conf/"

return {
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      local mason_null_ls = require("mason-null-ls")
      mason_null_ls.setup({
        ensure_installed = {
          "ansible-lint",
          "jsonlint",
          "luacheck",
          "markdownlint",
          "ruff",
          "shellcheck",
          "yamllint",
          "hadolint",

          "beautysh",
          "black",
          "isort",
          "prettier",
          "stylua",
          "xmlformatter",
          "yamlfmt",
        },
        automatic_installation = true,
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "jay-babu/mason-null-ls.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

      local lsp_formatting = function(bufnr)
        vim.lsp.buf.format({
          filter = function(client)
            -- use only null-ls for formatting (eg, not tsserver)
            return client.name == "null-ls"
          end,
          bufnr = bufnr,
        })
      end

      null_ls.setup({
        sources = {
          -- null_ls.builtins.diagnostics.ansiblelint,
          -- null_ls.builtins.diagnostics.jsonlint,
          -- null_ls.builtins.diagnostics.markdownlint,
          -- null_ls.builtins.diagnostics.ruff,
          -- null_ls.builtins.diagnostics.shellcheck,
          -- null_ls.builtins.diagnostics.yamllint,
          -- null_ls.builtins.diagnostics.hadolint,

          null_ls.builtins.formatting.beautysh.with({
            extra_args = { "--indent-size", "2" },
          }),
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort.with({
            filetypes = { "python" },
            extra_args = {
              "--dont-order-by-type",
              "--force-single-line-imports",
              "--force-sort-within-sections",
              "--line-length=80",
            },
          }),
          null_ls.builtins.formatting.prettier.with({
            filetypes = { "html", "json", "jsonc", "yaml", "markdown" },
            extra_args = { "--print-width", "120" },
          }),
          null_ls.builtins.formatting.stylua.with({
            filetypes = { "lua" },
            extra_args = {
              "--config-path",
              default_config_dir .. "stylua.toml",
            },
          }),
          null_ls.builtins.formatting.xmlformat,
          null_ls.builtins.formatting.yamlfmt,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            -- enable auto format when saving
            -- vim.api.nvim_create_autocmd("BufWritePre", {
            -- 	group = augroup,
            -- 	buffer = bufnr,
            -- 	callback = function()
            -- 		lsp_formatting(bufnr)
            -- 	end,
            -- })
          end
          local bufopts = { desc = "Format document", noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "<leader>f", lsp_formatting, bufopts)
        end,
      })

      -- vim.api.nvim_create_user_command("NullLsDisableLspFormatting", function()
      --   vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
      -- end, { nargs = 0 })
    end,
  },

  -- {
  -- 	"stevearc/conform.nvim",
  -- 	config = function()
  -- 		local conform = require("conform")
  -- 		conform.setup({
  -- 			formatters_by_ft = {
  -- 				lua = { "stylua" },
  -- 				python = { "isort", "black" },
  -- 				javascript = { "prettier" },
  -- 			},
  -- 			format_on_save = {
  -- 				lsp_fallback = true,
  -- 				async = false,
  -- 				timeout_ms = 1000,
  -- 			},
  -- 		})
  --
  -- 		vim.keymap.set({ "n", "v" }, "<leader>F", function()
  -- 			conform.format({
  -- 				lsp_fallback = true,
  -- 				async = false,
  -- 				timeout_ms = 1000,
  -- 			})
  -- 		end, { desc = "Format File With Conform", noremap = true, silent = true })
  -- 	end,
  -- },
}
