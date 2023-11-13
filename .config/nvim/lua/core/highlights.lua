vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.wildoptions = "pum"
vim.opt.pumblend = 5
vim.opt.background = "dark"

vim.api.nvim_create_autocmd("ColorScheme", {
	command = [[
    highlight CursorLine guibg=#43595e cterm=underline
  ]],
})

-- highlight yanked text for 200ms using the "Visual" highlight group
vim.cmd([[
  augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=100})
  augroup END
]])

vim.cmd([[
  augroup cursorline
  autocmd!
  autocmd WinEnter,BufEnter * setlocal cursorline cursorcolumn
  autocmd WinLeave,BufLeave * setlocal nocursorline nocursorcolumn
  augroup END
]])
