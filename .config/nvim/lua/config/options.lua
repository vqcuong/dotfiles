-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.mouse = ""
vim.opt.guicursor = "i-ci:block-blinkwait300-blinkon200-blinkoff150"

-- for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.formatoptions = "jcroqlnt" -- tcqj

vim.wo.number = true
vim.opt.relativenumber = false

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.inccommand = "split"
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" }) -- Finding files - Search down into subfolders
vim.opt.wildignore:append({ "*/node_modules/*" })

vim.opt.winblend = 0
vim.opt.wildoptions = "pum"

vim.api.nvim_create_autocmd("ColorScheme", {
  command = [[
    highlight CursorLine guibg=#202e30 cterm=underline
  ]],
})

-- disable highlight on inactive windows and buffers
vim.cmd([[
  augroup cursorline
  autocmd!
  autocmd WinEnter,BufEnter * setlocal cursorline cursorcolumn
  autocmd WinEnter,BufEnter * if &ft == "NvimTree" | setlocal cursorline nocursorcolumn
  autocmd WinLeave,BufLeave * setlocal nocursorline nocursorcolumn
  augroup END
]])
