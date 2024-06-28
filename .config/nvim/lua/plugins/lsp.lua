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

  -- {
  --   "neovim/nvim-lspconfig",
  --   -- requires = {
  --   --   "b0o/SchemaStore.nvim",
  --   --   "someone-stole-my-name/yaml-companion.nvim",
  --   -- },
  --   config = function()
  --     local lspconfig = require("lspconfig")
  --     lspconfig.yamlls.setup({
  --       settings = {
  --         redhat = { telemetry = { enabled = false } },
  --         yaml = {
  --           validate = true,
  --           format = { enable = true },
  --           hover = true,
  --           schemaStore = {
  --             enable = true,
  --             url = "https://www.schemastore.org/api/json/catalog.json",
  --           },
  --           schemaDownload = { enable = true },
  --           -- schemas = require("schemastore").yaml.schemas({
  --           --   extra = {
  --           --     {
  --           --       name = "kubernetes",
  --           --       url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.30.2-standalone-strict/all.json",
  --           --       fileMatch = { "k8s**.{yaml,yml}", "kube*/*.{yaml,yml}", "k8s/*.{yaml,yml}", "abc.yaml" },
  --           --       description = "Kubernetes",
  --           --     },
  --           --     {
  --           --       name = "gitlab-ci",
  --           --       url = "https://json.schemastore.org/gitlab-ci",
  --           --       fileMatch = { "*gitlab-ci*.{yml,yaml}" },
  --           --       description = "Gitlab CI",
  --           --     },
  --           --     {
  --           --       name = "github-action",
  --           --       url = "http://json.schemastore.org/github-action",
  --           --       fileMatch = { ".github/action.{yml,yaml}" },
  --           --       description = "Github Action",
  --           --     },
  --           --     {
  --           --       name = "github-workflow",
  --           --       url = "https://json.schemastore.org/github-workflow.json",
  --           --       fileMatch = { ".github/workflows/*.{yml,yaml}" },
  --           --       description = "Github Workflow",
  --           --     },
  --           --     {
  --           --       name = "helm-chart",
  --           --       url = "http://json.schemastore.org/chart",
  --           --       fileMatch = { "Chart.{yml,yaml}" },
  --           --       description = "Helm Chart",
  --           --     },
  --           --     {
  --           --       name = "kustomization",
  --           --       url = "http://json.schemastore.org/kustomization",
  --           --       fileMatch = { "kustomization.{yml,yaml}" },
  --           --       description = "Kustomization",
  --           --     },
  --           --     {
  --           --       name = "docker-compose",
  --           --       url = "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json",
  --           --       fileMatch = { "*docker-compose*.{yml,yaml}", "compose.yaml", "containers/*.{yaml,yml}" },
  --           --       description = "Docker Compose",
  --           --     },
  --           --   },
  --           -- }),
  --           schemas = {
  --             ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.30.2-standalone-strict/all.json"] = {
  --               "k8s**.{yml,yaml}",
  --               "kube*/*.{yml,yaml}",
  --               "k8s/*.{yml,yaml}",
  --             },
  --             ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
  --             ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
  --             ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
  --             ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
  --             ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
  --             ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
  --           },
  --         },
  --       },
  --     })
  --
  --     lspconfig.dockerls.setup({})
  --     lspconfig.fish_lsp.setup({})
  --   end,
  -- },
}
