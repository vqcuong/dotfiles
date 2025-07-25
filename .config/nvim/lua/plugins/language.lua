return {

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "fish",
        -- "sql",
        -- "dart",
      },
    },
  },

  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        -- "dcm",
        "hadolint",
      },
      ui = {
        width = 0.6,
        height = 0.6,
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        zsh = { "zsh" },
        -- html = { "htmlhint" },
        fish = { "fish" },
      },
    },
  },

  -- {
  --   "akinsho/flutter-tools.nvim",
  --   lazy = false,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "stevearc/dressing.nvim", -- optional for vim.ui.select
  --   },
  --   config = function()
  --     require("flutter-tools").setup({
  --       decorations = {
  --         statusline = {
  --           app_version = true,
  --           device = true,
  --         },
  --       },
  --       flutter_path = vim.fn.exepath("flutter"),
  --       widget_guides = {
  --         enable = true,
  --       },
  --       dev_tools = {
  --         autostart = true,
  --       },
  --     })
  --
  --     local function augroup(name)
  --       return vim.api.nvim_create_augroup("my_augroup_" .. name, { clear = true })
  --     end
  --
  --     vim.api.nvim_create_autocmd("FileType", {
  --       group = augroup("FlutterTelescope"),
  --       pattern = "dart",
  --       callback = function()
  --         vim.api.nvim_create_user_command("Flutter", function()
  --           require("telescope").extensions.flutter.commands()
  --         end, {})
  --       end,
  --     })
  --   end,
  -- },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft["sh"] = { "shfmt" }
      opts.formatters_by_ft["bash"] = { "shfmt" }
      opts.formatters_by_ft["python"] = { "isort", "black" }
      -- opts.formatters_by_ft["json"] = { "prettier" }
      -- opts.formatters_by_ft["html"] = { "prettier" }
      -- opts.formatters_by_ft["css"] = { "prettier" }
      -- opts.formatters_by_ft["js"] = { "prettier" }
      -- opts.formatters_by_ft["ts"] = { "prettier" }
      -- opts.formatters_by_ft["dart"] = { "dcm_format", "dart_format" }

      -- opts.formatters.autopep8 = {
      --   prepend_args = { "--indent-size", "2" },
      -- }
      -- opts.formatters.beautysh = {
      --   prepend_args = { "--indent-size", "2" },
      -- }
      opts.formatters.shfmt = {
        prepend_args = { "-i", "2" },
      }
    end,
  },
}
