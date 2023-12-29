return {
  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua" },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
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
