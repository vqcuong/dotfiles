return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },

      { "<localleader>c", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    },
    opts = {
      -- Server Configuration
      port_range = { min = 10000, max = 65535 },
      auto_start = true,
      log_level = "info", -- "trace", "debug", "info", "warn", "error"
      terminal_cmd = nil, -- Custom terminal command (default: "claude")

      -- Selection Tracking
      track_selection = true,
      visual_demotion_delay_ms = 50,

      -- Terminal Configuration
      terminal = {
        split_side = "right", -- "left" or "right"
        split_width_percentage = 0.30,
        provider = "auto", -- "auto", "snacks", or "native"
        auto_close = true,
        snacks_win_opts = {}, -- Opts to pass to `Snacks.terminal.open()`
      },

      -- Diff Integration
      diff_opts = {
        auto_close_on_accept = true,
        vertical_split = true,
        open_in_current_tab = true,
      },
    },
    -- keys = function()
    --   require("which-key").add({
    --     { "<leader>a", group = "AI/Claude Code" },
    --     { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    --     { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    --     { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    --     { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    --     { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
    --     { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    --     { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    --     -- Diff management
    --     { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    --     { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    --
    --     { "<localleader>c", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    --   })
    -- end,
  },

  -- {
  --   "greggh/claude-code.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim", -- Required for git operations
  --   },
  --   config = function()
  --     require("claude-code").setup({
  --       window = {
  --         split_ratio = 0.35,
  --         position = "float",
  --         float = {
  --           width = "40%",
  --           height = "100%",
  --           col = "60%",
  --         },
  --       },
  --       refresh = {
  --         enable = true,
  --         show_notifications = false,
  --       },
  --       keymaps = {
  --         toggle = {
  --           normal = "<C-c>",
  --           terminal = "<C-c>",
  --           variants = {
  --             continue = "<leader>cC",
  --             verbose = "<leader>cV",
  --           },
  --         },
  --         window_navigation = true,
  --         scrolling = true,
  --       },
  --     })
  --   end,
  -- },
}
