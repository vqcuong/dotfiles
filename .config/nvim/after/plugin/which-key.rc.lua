vim.o.timeout = true
vim.o.timeoutlen = 300

local status, wk = pcall(require, "which-key")
if not status then
	return
end

wk.setup({})
