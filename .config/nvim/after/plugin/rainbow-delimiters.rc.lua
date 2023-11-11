local status, rd = pcall(require("rainbow-delimiters"))
if not status then
	return
end

require("rainbow-delimiters.setup").setup({
	strategy = {
		[""] = rd.strategy["global"],
		vim = rd.strategy["local"],
	},
	query = {
		[""] = "rainbow-delimiters",
		lua = "rainbow-blocks",
	},
	highlight = {
		"RainbowDelimiterRed",
		"RainbowDelimiterYellow",
		"RainbowDelimiterBlue",
		"RainbowDelimiterOrange",
		"RainbowDelimiterGreen",
		"RainbowDelimiterViolet",
		"RainbowDelimiterCyan",
	},
})
