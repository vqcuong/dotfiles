local status, tint = pcall(require, "tint")
if not status then
  return
end

tint.setup({
	tint = -55,
	saturation = 0.60,
	transforms = require("tint").transforms.SATURATE_TINT,
	tint_background_colors = true,
	highlight_ignore_patterns = { "WinSeparator", "Status.*" },
	window_ignore_function = function(winid)
		local bufid = vim.api.nvim_win_get_buf(winid)
		local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
		local floating = vim.api.nvim_win_get_config(winid).relative ~= ""
		return buftype == "terminal" or floating
	end,
})
