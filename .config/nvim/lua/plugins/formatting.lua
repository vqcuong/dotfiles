return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "isort")
      table.insert(opts.ensure_installed, "autopep8")
      table.insert(opts.ensure_installed, "beautysh")
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, nls.builtins.formatting.shellharden)
      -- table.insert(opts.sources, nls.builtins.formatting.shfmt)

      table.insert(opts.sources, nls.builtins.diagnostics.fish)
      table.insert(opts.sources, nls.builtins.diagnostics.zsh)

      table.insert(opts.sources, nls.builtins.hover.printenv)
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft["sh"] = { "shfmt" }
      opts.formatters_by_ft["bash"] = { "shfmt", "beautysh" }
      opts.formatters_by_ft["python"] = { "isort", "autopep8" }
      opts.formatters_by_ft["zsh"] = { "beautysh" }
      opts.formatters_by_ft["fish"] = { "fish_indent" }
      opts.formatters_by_ft["go"] = { "gofmt", "goimports" }
      opts.formatters_by_ft["json"] = { "prettier" }
      opts.formatters_by_ft["json"] = { "prettier" }
      opts.formatters_by_ft["html"] = { "prettier" }
      opts.formatters_by_ft["css"] = { "prettier" }
      opts.formatters_by_ft["js"] = { "prettier" }
      opts.formatters_by_ft["ts"] = { "prettier" }
      opts.formatters_by_ft["sql"] = { "sql_formatter" }
      opts.formatters_by_ft["tf"] = { "terraform_fmt" }

      opts.formatters.autopep8 = {
        prepend_args = { "--indent-size", "2" },
      }
      opts.formatters.beautysh = {
        prepend_args = { "--indent-size", "2" },
      }
      opts.formatters.shfmt = {
        prepend_args = { "-i", "2" },
      }
    end,
  },
}
