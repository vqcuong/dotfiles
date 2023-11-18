-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("my_augroup_" .. name, { clear = true })
end

-- disable auto comment when insert new line after comment
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("format_options"),
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove({ "r", "o" })
  end,
})

-- instantly hide diagnostic when entering insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
  group = augroup("hide_diagnostic"),
  pattern = "*",
  callback = function()
    vim.diagnostic.hide(nil, 0)
  end,
})

-- instantly show diagnostic when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  group = augroup("show_diagnostic"),
  pattern = "*",
  callback = function()
    vim.diagnostic.show(nil, 0)
  end,
})

-- disable paste when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  group = augroup("disable_paste"),
  pattern = "*",
  command = "set nopaste",
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "floggraph",
    "NeogitStatus",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "DiffviewFiles",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>DiffviewClose<cr>", { buffer = event.buf, silent = true })
  end,
})
