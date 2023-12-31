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
      table.insert(opts.sources, nls.builtins.formatting.isort)
      table.insert(opts.sources, nls.builtins.formatting.autopep8)
      table.insert(opts.sources, nls.builtins.formatting.beautysh)
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft["python"] = { "isort", "autopep8" }
      opts.formatters_by_ft["zsh"] = { "beautysh" }
      opts.formatters.autopep8 = {
        prepend_args = { "--indent-size", "2" },
      }
      opts.formatters.beautysh = {
        prepend_args = { "--indent-size", "2" },
      }
    end,
  },
}
