return {

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "dart", "fish", "sql" } },
  },

  {
    "mason.nvim",
    opts = {
      ensure_installed = { "hadolint", "htmlhint", "shellharden", "dcm" },
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
        html = { "htmlhint" },
        fish = { "fish" },
      },
    },
  },

  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = function()
      require("flutter-tools").setup({
        decorations = {
          statusline = {
            app_version = true,
            device = true,
          },
        },
        flutter_path = vim.fn.exepath("flutter"),
        widget_guides = {
          enable = true,
        },
        dev_tools = {
          autostart = true,
        },
      })

      local function augroup(name)
        return vim.api.nvim_create_augroup("my_augroup_" .. name, { clear = true })
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = augroup("FlutterTelescope"),
        pattern = "dart",
        callback = function()
          vim.api.nvim_create_user_command("Flutter", function()
            require("telescope").extensions.flutter.commands()
          end, {})
        end,
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft["sh"] = { "shfmt", "shellharden" }
      opts.formatters_by_ft["bash"] = { "shfmt", "beautysh", "shellharden" }
      opts.formatters_by_ft["zsh"] = { "beautysh", "shellharden" }
      opts.formatters_by_ft["python"] = { "isort", "autopep8" }
      opts.formatters_by_ft["json"] = { "prettier" }
      opts.formatters_by_ft["html"] = { "prettier" }
      opts.formatters_by_ft["css"] = { "prettier" }
      opts.formatters_by_ft["js"] = { "prettier" }
      opts.formatters_by_ft["ts"] = { "prettier" }
      opts.formatters_by_ft["dart"] = { "dcm_format", "dart_format" }

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

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        fish_lsp = {},
      },
    },
    -- config = function()
    --   local lspconfig = require("lspconfig")
    --   lspconfig.yamlls.setup({
    --     settings = {
    --       yaml = {
    --         hover = true,
    --         schemas = require("schemastore").yaml.schemas({
    --           extra = {
    --             {
    --               name = "kubernetes",
    --               url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.30.2-standalone-strict/all.json",
    --               fileMatch = { "k8s**.{yaml,yml}", "kube*/*.{yaml,yml}", "k8s/*.{yaml,yml}", "abc.yaml" },
    --               description = "Kubernetes",
    --             },
    --             {
    --               name = "gitlab-ci",
    --               url = "https://json.schemastore.org/gitlab-ci",
    --               fileMatch = { "*gitlab-ci*.{yml,yaml}" },
    --               description = "Gitlab CI",
    --             },
    --             {
    --               name = "github-action",
    --               url = "http://json.schemastore.org/github-action",
    --               fileMatch = { ".github/action.{yml,yaml}" },
    --               description = "Github Action",
    --             },
    --             {
    --               name = "github-workflow",
    --               url = "https://json.schemastore.org/github-workflow.json",
    --               fileMatch = { ".github/workflows/*.{yml,yaml}" },
    --               description = "Github Workflow",
    --             },
    --             {
    --               name = "helm-chart",
    --               url = "http://json.schemastore.org/chart",
    --               fileMatch = { "Chart.{yml,yaml}" },
    --               description = "Helm Chart",
    --             },
    --             {
    --               name = "kustomization",
    --               url = "http://json.schemastore.org/kustomization",
    --               fileMatch = { "kustomization.{yml,yaml}" },
    --               description = "Kustomization",
    --             },
    --             {
    --               name = "docker-compose",
    --               url = "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json",
    --               fileMatch = { "*docker-compose*.{yml,yaml}", "compose.yaml", "containers/*.{yaml,yml}" },
    --               description = "Docker Compose",
    --             },
    --           },
    --         }),
    --         -- schemas = {
    --         --   ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.30.2-standalone-strict/all.json"] = {
    --         --     "k8s**.{yml,yaml}",
    --         --     "kube*/*.{yml,yaml}",
    --         --     "k8s/*.{yml,yaml}",
    --         --   },
    --         --   ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
    --         --   ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
    --         --   ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
    --         --   ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
    --         --   ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
    --         --   ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
    --         -- },
    --       },
    --     },
    --   })
    -- end,
  },

  -- {
  --   "nvim-lualine/lualine.nvim",
  --   -- lazy = false,
  --   opts = function(_, opts)
  --     local flutter_device = function()
  --       if vim.g.flutter_tools_decorations.device ~= nil then
  --         return vim.g.flutter_tools_decorations.device.name
  --       end
  --       return ""
  --     end
  --     if opts.sections.lualine_z == nil then
  --       opts.sections.lualine_z = {}
  --     end
  --     table.insert(opts.sections.lualine_z, flutter_device)
  --   end,
  -- },
}
