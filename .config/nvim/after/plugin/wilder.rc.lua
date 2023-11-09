local status, wilder = pcall(require, "wilder")
if not status then
	return
end

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
