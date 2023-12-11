-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.mouse = ""
vim.opt.guicursor = "i-ci:block-blinkwait300-blinkon200-blinkoff150"

-- disable deprecated ts-context-commentstring module
vim.g.skip_ts_context_commentstring_module = true

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.wo.number = true
vim.opt.relativenumber = false
vim.opt.title = true
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }

-- Finding files - Search down into subfolders
vim.opt.path:append({ "**" })

vim.opt.undofile = false
-- increase this will impact the which-key background transparent
vim.opt.winblend = 0
vim.opt.pumblend = 0
