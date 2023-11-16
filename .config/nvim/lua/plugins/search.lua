return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash Jump",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
    config = function()
      require("flash").setup({
        modes = {
          char = {
            keys = { "s", "S" },
          },
        },
      })
    end,
  },
  {
    "phaazon/hop.nvim",
    event = "VeryLazy",
    config = function()
      local hop = require("hop")
      local directions = require("hop.hint").HintDirection
      local positions = require("hop.hint").HintPosition

      hop.setup({ hint_position = positions.END })

      vim.keymap.set("", "f", function()
        hop.hint_char1()
      end, { remap = true })
      vim.keymap.set("", "F", function()
        hop.hint_char2()
      end, { remap = true })
      -- vim.keymap.set("", "t", function()
      -- 	hop.hint_char1({
      -- 		direction = directions.AFTER_CURSOR,
      -- 	})
      -- end, { remap = true })
      -- vim.keymap.set("", "T", function()
      -- 	hop.hint_char1({
      -- 		direction = directions.BEFORE_CURSOR,
      -- 	})
      -- end, { remap = true })
      vim.keymap.set("", "L", function()
        hop.hint_lines_skip_whitespace()
      end, { remap = true })
      vim.keymap.set("", "P", function()
        hop.hint_patterns()
      end, { remap = true })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "nvim-telescope/telescope-file-browser.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")
      local themes = require("telescope.themes")
      -- local fb_actions = require("telescope").extensions.file_browser.actions

      telescope.setup({
        defaults = {
          mappings = {
            n = {
              ["q"] = actions.close,
            },
          },
          winblend = 0,
          prompt_prefix = " ",
          selection_caret = "> ",
          multi_icon = "",
          initial_mode = "normal",
          border = false,
          path_display = {
            "smart",
          },
          file_ignore_patterns = {
            "^.git/",
          },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
          },
        },
        -- extensions = {
        -- 	file_browser = {
        -- 		theme = "dropdown",
        -- 		-- disables netrw and use telescope-file-browser in its place
        -- 		hijack_netrw = true,
        -- 		mappings = {
        -- 			-- your custom insert mode mappings
        -- 			["i"] = {
        -- 				["<C-w>"] = function()
        -- 					vim.cmd("normal vbd")
        -- 				end,
        -- 			},
        -- 			["n"] = {
        -- 				-- your custom normal mode mappings
        -- 				["N"] = fb_actions.create,
        -- 				["h"] = fb_actions.goto_parent_dir,
        -- 				["/"] = function()
        -- 					vim.cmd("startinsert")
        -- 				end,
        -- 				["<C-u>"] = function(prompt_bufnr)
        -- 					for i = 1, 10 do
        -- 						actions.move_selection_previous(prompt_bufnr)
        -- 					end
        -- 				end,
        -- 				["<C-d>"] = function(prompt_bufnr)
        -- 					for i = 1, 10 do
        -- 						actions.move_selection_next(prompt_bufnr)
        -- 					end
        -- 				end,
        -- 				["<PageUp>"] = actions.preview_scrolling_up,
        -- 				["<PageDown>"] = actions.preview_scrolling_down,
        -- 			},
        -- 		},
        -- 	},
        -- },
      })

      local function opts(desc)
        return { desc = "Telescope: " .. desc, noremap = true, silent = true, nowait = true }
      end

      -- telescope.load_extension("file_browser")
      -- local function telescope_buffer_dir()
      -- 	return vim.fn.expand("%:p:h")
      -- end
      -- vim.keymap.set("n", "\\b", function()
      -- 	telescope.extensions.file_browser.file_browser({
      -- 		path = "%:p:h",
      -- 		cwd = telescope_buffer_dir(),
      -- 		respect_gitignore = false,
      -- 		hidden = true,
      -- 		grouped = true,
      -- 		previewer = true,
      -- 		initial_mode = "insert",
      -- 		layout_config = { height = 30 },
      -- 	})
      -- end, opts("File Browser"))
    end,
    keys = {
      {
        "\\s",
        function()
          require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({
            border = false,
            follow = true,
            no_ignore = true,
            hidden = true,
            initial_mode = "insert",
          }))
        end,
        desc = "Telescope find files",
      },
      {
        "\\l",
        function()
          require("telescope.builtin").live_grep(require("telescope.themes").get_dropdown({
            border = false,
            hidden = true,
            additional_args = { "--hidden" },
            max_results = 100,
            initial_mode = "insert",
          }))
        end,
        desc = "Telescope live grep",
      },
      {
        "\\b",
        function()
          require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({
            border = false,
            ignore_current_buffer = true,
            sort_lastused = true,
          }))
        end,
        desc = "Telescope buffers",
      },
      {
        "\\h",
        function()
          require("telescope.builtin").help_tags(require("telescope.themes").get_dropdown({
            border = false,
            initial_mode = "insert",
          }))
        end,
        desc = "Telescope helps",
      },
      {
        "\\p",
        function()
          require("telescope.builtin").resume(require("telescope.themes").get_dropdown({
            border = false,
          }))
        end,
        desc = "Telescope last previewer",
      },
      {
        "\\k",
        function()
          require("telescope.builtin").keymaps(require("telescope.themes").get_dropdown({
            border = false,
          }))
        end,
        desc = "Telescope keymaps ",
      },
      {
        "\\cs",
        function()
          require("telescope.builtin").colorscheme(require("telescope.themes").get_dropdown({
            border = false,
            enable_preview = true,
            initial_mode = "insert",
          }))
        end,
        desc = "Telescope colorscheme",
      },

      {
        "\\cc",
        function()
          require("telescope.builtin").commands(require("telescope.themes").get_dropdown({
            border = false,
            initial_mode = "insert",
          }))
        end,
        desc = "Telescope commands",
      },
      {
        "\\ca",
        function()
          require("telescope.builtin").autocommands(require("telescope.themes").get_dropdown({
            border = false,
            initial_mode = "insert",
          }))
        end,
        desc = "Telescope autocommands",
      },

      {
        "\\d",
        function()
          require("telescope.builtin").diagnostics(require("telescope.themes").get_cursor({
            border = false,
            layout_config = {
              width = 20,
              height = 10,
            },
          }))
        end,
        desc = "Telescope diagnostics",
      },
      {
        "\\S",
        function()
          require("telescope.builtin").spell_suggest(require("telescope.themes").get_cursor({
            border = false,
            layout_config = {
              width = 20,
              height = 10,
            },
          }))
        end,
        desc = "Telescope spell suggest",
      },
      {
        "\\R",
        function()
          require("telescope.builtin").lsp_references(require("telescope.themes").get_cursor({
            border = false,
            layout_config = {
              width = 20,
              height = 10,
            },
          }))
        end,
        desc = "Telescope lsp references",
      },

      {
        "\\D",
        function()
          require("telescope.builtin").lsp_definitions(require("telescope.themes").get_cursor({
            border = false,
            layout_config = {
              width = 20,
              height = 10,
            },
          }))
        end,
        desc = "Telescope lsp definitions",
      },
      {
        "\\T",
        function()
          require("telescope.builtin").lsp_type_definitions(require("telescope.themes").get_cursor({
            border = false,
            layout_config = {
              width = 20,
              height = 10,
            },
          }))
        end,
        desc = "Telescope lsp type definitions",
      },
      {
        "\\I",
        function()
          require("telescope.builtin").lsp_implementations(require("telescope.themes").get_cursor({
            border = false,
            layout_config = {
              width = 20,
              height = 10,
            },
          }))
        end,
        desc = "Telescope lsp implementations",
      },
    },
  },

  -- {
  -- 	"gelguy/wilder.nvim",
  -- 	config = function()
  -- 		local wilder = require("wilder")
  -- 		local gradient = {
  -- 			"#f4468f",
  -- 			"#fd4a85",
  -- 			"#ff507a",
  -- 			"#ff566f",
  -- 			"#ff5e63",
  -- 			"#ff6658",
  -- 			"#ff704e",
  -- 			"#ff7a45",
  -- 			"#ff843d",
  -- 			"#ff9036",
  -- 			"#f89b31",
  -- 			"#efa72f",
  -- 			"#e6b32e",
  -- 			"#dcbe30",
  -- 			"#d2c934",
  -- 			"#c8d43a",
  -- 			"#bfde43",
  -- 			"#b6e84e",
  -- 			"#aff05b",
  -- 		}
  --
  -- 		for i, fg in ipairs(gradient) do
  -- 			gradient[i] =
  -- 				wilder.make_hl("WilderGradient" .. i, "Pmenu", { { a = 1 }, { a = 1 }, { foreground = fg } })
  -- 		end
  --
  -- 		wilder.setup({
  -- 			modes = { ":", "/", "?" },
  -- 			next_key = "<Tab>",
  -- 			previous_key = "<S-Tab>",
  -- 		})
  --
  -- 		wilder.set_option("pipeline", {
  -- 			wilder.branch(
  -- 				wilder.python_file_finder_pipeline({
  -- 					file_command = { "fd", "-tf", "-H", "-E", ".git" },
  -- 					dir_command = { "fd", "fi", "--type", "d", "-H", "--max-depth", "5" },
  -- 					filters = { "fuzzy_filter", "difflib_sorter" },
  -- 				}),
  -- 				wilder.substitute_pipeline({
  -- 					pipeline = wilder.python_search_pipeline({
  -- 						skip_cmdtype_check = 1,
  -- 						pattern = wilder.python_fuzzy_pattern({
  -- 							start_at_boundary = 0,
  -- 						}),
  -- 					}),
  -- 				}),
  -- 				wilder.cmdline_pipeline({
  -- 					language = "python",
  -- 					fuzzy = 1,
  -- 				}),
  -- 				{
  -- 					wilder.check(function(ctx, x)
  -- 						return x == ""
  -- 					end),
  -- 					wilder.history(),
  -- 				},
  -- 				wilder.python_search_pipeline({
  -- 					pattern = wilder.python_fuzzy_pattern({
  -- 						start_at_boundary = 0,
  -- 					}),
  -- 				})
  -- 			),
  -- 		})
  -- 		wilder.set_option(
  -- 			"renderer",
  -- 			-- wilder.popupmenu_renderer(wilder.popupmenu_palette_theme({
  -- 			-- 	highlights = {
  -- 			-- 		gradient = gradient,
  -- 			-- 	},
  -- 			-- 	border = "rounded",
  -- 			-- 	max_height = "65%",
  -- 			-- 	min_height = "20%",
  -- 			-- 	max_width = "50%",
  -- 			-- 	min_width = "20%",
  -- 			-- 	prompt_position = "top",
  -- 			-- 	highlighter = wilder.highlighter_with_gradient({
  -- 			-- 		wilder.basic_highlighter(),
  -- 			-- 	}),
  -- 			-- 	left = { " ", wilder.popupmenu_devicons() },
  -- 			-- 	pumblend = 10,
  -- 			-- }))
  -- 			wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
  -- 				highlights = {
  -- 					gradient = gradient,
  -- 				},
  -- 				border = "rounded",
  -- 				empty_message = wilder.popupmenu_empty_message_with_spinner(),
  -- 				highlighter = wilder.highlighter_with_gradient({
  -- 					wilder.basic_highlighter(),
  -- 				}),
  -- 				left = {
  -- 					" ",
  -- 					wilder.popupmenu_devicons(),
  -- 					wilder.popupmenu_buffer_flags({
  -- 						flags = " a + ",
  -- 						icons = { ["+"] = "", a = "", h = "" },
  -- 					}),
  -- 				},
  -- 				right = {
  -- 					" ",
  -- 					wilder.popupmenu_scrollbar(),
  -- 				},
  -- 				pumblend = 10,
  -- 			}))
  -- 		)
  -- 	end,
  -- },

  -- {
  -- 	"ibhagwan/fzf-lua",
  -- 	config = function()
  -- 		local fzf = require("fzf-lua")
  --
  -- 		local function opts(desc)
  -- 			return { desc = "FZF: " .. desc, silent = true }
  -- 		end
  -- 		vim.keymap.set("n", ";ff", function()
  -- 			fzf.files()
  -- 		end, opts("Files"))
  -- 		vim.keymap.set("n", ";bf", function()
  -- 			fzf.buffers()
  -- 		end, opts("Buffers"))
  -- 		vim.keymap.set("n", ";gg", function()
  -- 			fzf.grep()
  -- 		end, opts("Grep"))
  -- 		vim.keymap.set("n", ";lg", function()
  -- 			fzf.live_grep()
  -- 		end, opts("Live grep"))
  -- 		vim.keymap.set("n", ";bt", function()
  -- 			fzf.builtin()
  -- 		end, opts("Builtin"))
  -- 		vim.keymap.set("n", ";ht", function()
  -- 			fzf.help_tags()
  -- 		end, opts("Help"))
  -- 		vim.keymap.set("n", ";km", function()
  -- 			fzf.keymaps()
  -- 		end, opts("Keymaps"))
  -- 		vim.keymap.set("n", ";ft", function()
  -- 			fzf.filetypes()
  -- 		end, opts("Filetypes"))
  -- 		vim.keymap.set("n", ";mn", function()
  -- 			fzf.menus()
  -- 		end, opts("Menus"))
  -- 	end,
  -- },
}
