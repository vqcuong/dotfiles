if true then
  return {}
end

return {
  "voldikss/vim-floaterm",
  "stevearc/oil.nvim",
  "feline-nvim/feline.nvim",
  "simrat39/symbols-ouline.nvim",
  "stevearc/aerial.nvim",
  "terrortylor/nvim-comment",
  "rktjmp/lush.nvim",
  "ibhagwan/fzf-lua",
  "abecodes/tabout.nvim",
  "mrjones2014/legendary.nvim",
  "Pocco81/true-zen.nvim",
  "b3nj5m1n/kommentary",
  { "neoclide/coc.nvim", build = "npm ci" },
  { "airblade/vim-gitgutter", opts = {} },
  {
    "numToStr/FTerm.nvim",
    -- stylua: ignore
    keys = {
      { "<localleader>T", function() require("FTerm").toggle() end, desc = "Float terminal toggle", mode = { "n", "t", "v" } },
      { "<esc><esc>", function () require("FTerm").toggle()  end, silent = true, mode = {"t"} }
    },
    opts = {
      border = "single",
      auto_close = true,
      blend = 0,
      dimensions = {
        height = 0.6,
        width = 0.6,
        x = 0.5,
        y = 0.5,
      },
    },
  },
  {
    -- unused due to the conflict trouble with toggleterm
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    init = function()
      vim.o.winwidth = 8
      vim.o.winminwidth = 8
      vim.o.equalalways = false
    end,
    opts = {
      ignore = {
        buftype = { "nofile", "temrinal" },
        filetype = {
          "NvimTree",
          "neo-tree",
          "undotree",
          "gundo",
          "toggleterm",
        },
      },
    },
    config = true,
  },
  {
    "folke/twilight.nvim",
    opts = {
      dimming = {
        alpha = 0.5,
      },
      context = 20,
    },
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    tag = "legacy",
    config = function()
      require("fidget").setup({
        text = {
          spinner = "meter",
        },
        window = {
          blend = 0,
        },
      })
    end,
  },
  {
    "gelguy/wilder.nvim",
    config = function()
      local wilder = require("wilder")
      local gradient = {
        "#f4468f",
        "#fd4a85",
        "#ff507a",
        "#ff566f",
        "#ff5e63",
        "#ff6658",
        "#ff704e",
        "#ff7a45",
        "#ff843d",
        "#ff9036",
        "#f89b31",
        "#efa72f",
        "#e6b32e",
        "#dcbe30",
        "#d2c934",
        "#c8d43a",
        "#bfde43",
        "#b6e84e",
        "#aff05b",
      }

      for i, fg in ipairs(gradient) do
        gradient[i] = wilder.make_hl("WilderGradient" .. i, "Pmenu", { { a = 1 }, { a = 1 }, { foreground = fg } })
      end

      wilder.setup({
        modes = { ":", "/", "?" },
        next_key = "<Tab>",
        previous_key = "<S-Tab>",
      })

      wilder.set_option("pipeline", {
        wilder.branch(
          wilder.python_file_finder_pipeline({
            file_command = { "fd", "-tf", "-H", "-E", ".git" },
            dir_command = { "fd", "fi", "--type", "d", "-H", "--max-depth", "5" },
            filters = { "fuzzy_filter", "difflib_sorter" },
          }),
          wilder.substitute_pipeline({
            pipeline = wilder.python_search_pipeline({
              skip_cmdtype_check = 1,
              pattern = wilder.python_fuzzy_pattern({
                start_at_boundary = 0,
              }),
            }),
          }),
          wilder.cmdline_pipeline({
            language = "python",
            fuzzy = 1,
          }),
          {
            wilder.check(function(ctx, x)
              return x == ""
            end),
            wilder.history(),
          },
          wilder.python_search_pipeline({
            pattern = wilder.python_fuzzy_pattern({
              start_at_boundary = 0,
            }),
          })
        ),
      })
      wilder.set_option(
        "renderer",
        -- wilder.popupmenu_renderer(wilder.popupmenu_palette_theme({
        -- 	highlights = {
        -- 		gradient = gradient,
        -- 	},
        -- 	border = "rounded",
        -- 	max_height = "65%",
        -- 	min_height = "20%",
        -- 	max_width = "50%",
        -- 	min_width = "20%",
        -- 	prompt_position = "top",
        -- 	highlighter = wilder.highlighter_with_gradient({
        -- 		wilder.basic_highlighter(),
        -- 	}),
        -- 	left = { " ", wilder.popupmenu_devicons() },
        -- 	pumblend = 10,
        -- }))
        wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
          highlights = {
            gradient = gradient,
          },
          border = "rounded",
          empty_message = wilder.popupmenu_empty_message_with_spinner(),
          highlighter = wilder.highlighter_with_gradient({
            wilder.basic_highlighter(),
          }),
          left = {
            " ",
            wilder.popupmenu_devicons(),
            wilder.popupmenu_buffer_flags({
              flags = " a + ",
              icons = { ["+"] = "", a = "", h = "" },
            }),
          },
          right = {
            " ",
            wilder.popupmenu_scrollbar(),
          },
          pumblend = 10,
        }))
      )
    end,
  },
  {
    "aserowy/tmux.nvim",
    opts = {
      copy_sync = {
        enable = false,
      },
      navigation = {
        -- cycles to opposite pane while navigating into the border
        cycle_navigation = true,
        -- enables default keybindings (C-hjkl) for normal mode
        enable_default_keybindings = false,
        -- prevents unzoom tmux when navigating beyond vim border
        persist_zoom = false,
      },
      resize = {
        -- enables default keybindings (A-hjkl) for normal mode
        enable_default_keybindings = false,
        resize_step_x = 1,
        resize_step_y = 1,
      },
    },
    keys = {
      { "<m-left>", "<cmd>lua require('tmux').move_left()<cr>", desc = "Move left", mode = { "n", "t" } },
      { "<m-right>", "<cmd>lua require('tmux').move_right()<cr>", desc = "Move right", mode = { "n", "t" } },
      { "<m-up>", "<cmd>lua require('tmux').move_top()<cr>", desc = "Move up", mode = { "n", "t" } },
      { "<m-down>", "<cmd>lua require('tmux').move_bottom()<cr>", desc = "Move down", mode = { "n", "t" } },
      { "<m-h>", "<cmd>lua require('tmux').resize_left()<cr>", desc = "Resize left", mode = { "n", "t" } },
      { "<m-l>", "<cmd>lua require('tmux').resize_right()<cr>", desc = "Resize right", mode = { "n", "t" } },
      { "<m-j>", "<cmd>lua require('tmux').resize_top()<cr>", desc = "Resize up", mode = { "n", "t" } },
      { "<m-k>", "<cmd>lua require('tmux').resize_bottom()<cr>", desc = "Resize down", mode = { "n", "t" } },
    },
  },
  {
    "FabianWirth/search.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      {
        "<localleader><space>",
        "<cmd>lua require('search').open()<cr>",
        desc = "Telescope multiple space",
        mode = { "n", "v" },
      },
    },
    config = function()
      local builtin = require("telescope.builtin")
      require("search").setup({
        mappings = { -- optional: configure the mappings for switching tabs (will be set in normal and insert mode(!))
          next = "<Tab>",
          prev = "<S-Tab>",
        },
        append_tabs = { -- append_tabs will add the provided tabs to the default ones
          { "Buffers", builtin.buffers },
          { "Greps", builtin.live_grep },
          { "Diagnostics", builtin.diagnostics },
          { "References", builtin.lsp_references },
          -- stylua: ignore
          { "Commits", builtin.git_commits, available = function() return vim.fn.isdirectory(".git") == 1 end },
          { "Helps", builtin.help_tags },
          { "Highlights", builtin.highlights },
          { "Colorscheme", builtin.colorscheme },
        },
        tabs = {
          { "Files", builtin.find_files },
          -- stylua: ignore
          { "GitFiles", builtin.git_files, function() return vim.fn.isdirectory(".git") == 1 end },
        },
      })
    end,
  },

  {
    -- only have some usable commands
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua" },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },
}
