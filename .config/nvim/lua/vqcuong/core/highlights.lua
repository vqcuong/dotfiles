vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.wildoptions = "pum"
vim.opt.pumblend = 5
vim.opt.background = "dark"

vim.api.nvim_create_autocmd("ColorScheme", {
  command = [[
    highlight CursorLine guibg=#202e30 cterm=underline
  ]],
})

-- highlight yanked text for 200ms using the "Visual" highlight group
vim.cmd([[
  augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=100})
  augroup END
]])

-- disable highlight on inactive windows and buffers
vim.cmd([[
  augroup cursorline
  autocmd!
  autocmd WinEnter,BufEnter * setlocal cursorline cursorcolumn
  autocmd WinEnter,BufEnter * if &ft == "NvimTree" | setlocal cursorline nocursorcolumn
  autocmd WinLeave,BufLeave * setlocal nocursorline nocursorcolumn
  augroup END
]])

-- undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])