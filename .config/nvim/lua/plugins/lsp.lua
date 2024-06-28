return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        width = 0.6,
        height = 0.6,
      },
    },
  },

  {
    "someone-stole-my-name/yaml-companion.nvim",
    requires = {
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      require("telescope").load_extension("yaml_schema")
    end,
  },

  {
    "neovim/nvim-lspconfig",
    requires = {
      "b0o/SchemaStore.nvim",
      "someone-stole-my-name/yaml-companion.nvim",
    },
    opts = function()
      local cfg = require("yaml-companion").setup({
        -- detect k8s schemas based on file content
        builtin_matchers = {
          kubernetes = { enabled = true },
        },

        -- schemas available in Telescope picker
        schemas = {
          -- not loaded automatically, manually select with
          -- :Telescope yaml_schema
          -- schemas below are automatically loaded, but added
          -- them here so that they show up in the statusline
          {
            name = "kubernetes",
            uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.30.2-standalone-strict/all.json",
            fileMatch = { "k8s**.{yaml,yml}", "kube*/*.{yaml,yml}", "k8s/*.{yaml,yml}" },
            description = "Kubernetes 1.30.2",
          },
          {
            name = "gitlab-ci",
            uri = "https://json.schemastore.org/gitlab-ci",
            fileMatch = { "*gitlab-ci*.{yml,yaml}" },
            description = "Gitlab CI",
          },
          {
            name = "github-action",
            uri = "http://json.schemastore.org/github-action",
            fileMatch = { ".github/action.{yml,yaml}" },
            description = "Github Action",
          },
          {
            name = "github-workflow",
            uri = "https://json.schemastore.org/github-workflow.json",
            fileMatch = { ".github/workflows/*.{yml,yaml}" },
            description = "Github Workflow",
          },
          {
            name = "helm-chart",
            uri = "http://json.schemastore.org/chart",
            fileMatch = { "Chart.{yml,yaml}" },
            description = "Helm Chart",
          },
          {
            name = "kustomization",
            uri = "http://json.schemastore.org/kustomization",
            fileMatch = { "kustomization.{yml,yaml}" },
            description = "Kustomization",
          },
          {
            name = "docker-compose",
            uri = "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json",
            fileMatch = { "*docker-compose*.{yml,yaml}", "compose.yaml", "containers/*.{yaml,yml}" },
            description = "Docker Compose",
          },
        },

        lspconfig = {
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
              validate = true,
              format = { enable = true },
              hover = true,
              schemaStore = {
                enable = false,
                url = "",
              },

              -- schemas from store, matched by filename
              -- loaded automatically
              schemas = require("schemastore").yaml.schemas({}),
            },
          },
        },
      })
      local lspconfig = require("lspconfig")
      lspconfig.yamlls.setup(cfg)
      -- lspconfig.yamlls.setup({
      --   settings = {
      --     redhat = { telemetry = { enabled = false } },
      --     yaml = {
      --       validate = true,
      --       format = { enable = true },
      --       hover = true,
      --       schemaStore = {
      --         enable = true,
      --         url = "https://www.schemastore.org/api/json/catalog.json",
      --       },
      --       schemaDownload = { enable = true },
      --       schemas = require("schemastore").yaml.schemas({
      --         extra = {
      --           {
      --             name = "kubernetes",
      --             url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.30.2-standalone-strict/all.json",
      --             fileMatch = { "k8s**.{yaml,yml}", "kube*/*.{yaml,yml}", "k8s/*.{yaml,yml}" },
      --             description = "Kubernetes",
      --           },
      --           {
      --             name = "gitlab-ci",
      --             url = "https://json.schemastore.org/gitlab-ci",
      --             fileMatch = { "*gitlab-ci*.{yml,yaml}" },
      --             description = "Gitlab CI",
      --           },
      --           {
      --             name = "github-action",
      --             url = "http://json.schemastore.org/github-action",
      --             fileMatch = { ".github/action.{yml,yaml}" },
      --             description = "Github Action",
      --           },
      --           {
      --             name = "github-workflow",
      --             url = "https://json.schemastore.org/github-workflow.json",
      --             fileMatch = { ".github/workflows/*.{yml,yaml}" },
      --             description = "Github Workflow",
      --           },
      --           {
      --             name = "helm-chart",
      --             url = "http://json.schemastore.org/chart",
      --             fileMatch = { "Chart.{yml,yaml}" },
      --             description = "Helm Chart",
      --           },
      --           {
      --             name = "kustomization",
      --             url = "http://json.schemastore.org/kustomization",
      --             fileMatch = { "kustomization.{yml,yaml}" },
      --             description = "Kustomization",
      --           },
      --           {
      --             name = "docker-compose",
      --             url = "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json",
      --             fileMatch = { "*docker-compose*.{yml,yaml}", "compose.yaml", "containers/*.{yaml,yml}" },
      --             description = "Docker Compose",
      --           },
      --         },
      --       }),
      --       -- schemas = {
      --       --   ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.30.2-standalone-strict/all.json"] = {
      --       --     "k8s**.{yml,yaml}",
      --       --     "kube*/*.{yml,yaml}",
      --       --     "k8s/*.{yml,yaml}",
      --       --   },
      --       --   ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
      --       --   ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
      --       --   ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
      --       --   ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
      --       --   ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
      --       --   ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
      --       -- },
      --     },
      --   },
      -- })

      lspconfig.dockerls.setup({})
      lspconfig.fish_lsp.setup({})
    end,
  },
}
