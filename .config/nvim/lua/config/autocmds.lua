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
    "git",
    "fugitive",
    "fugitiveblame",
    "flutterToolsOutline",
    "log",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q_diffview"),
  pattern = {
    "DiffviewFiles",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>DiffviewClose<cr>", { buffer = event.buf, silent = true })
  end,
})

-- customize highlight cursorline
vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup("highlight_cursorline"),
  command = [[
    highlight CursorLine guibg=#202e30 cterm=underline
  ]],
})

-- disable special lines on certain windows
vim.cmd([[
  augroup cursorline
  autocmd!
  autocmd WinEnter,BufEnter * setlocal cursorline cursorcolumn
  autocmd WinEnter,BufEnter * if &ft == "NvimTree" | setlocal cursorline nocursorcolumn
  autocmd WinLeave,BufLeave * setlocal nocursorline nocursorcolumn
  autocmd TermOpen * setlocal signcolumn=no nocursorcolumn nonumber norelativenumber
  augroup END
]])

-- automatically active lspsaga symbol winbar whenever entering buffer
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("open_winbar"),
  pattern = "*",
  callback = function()
    local status, winbar = pcall(require, "lspsaga.symbol.winbar")
    if not status then
      return
    end
    local curbuf = vim.api.nvim_get_current_buf()
    local bo = vim.bo[curbuf]
    local disallow_filetypes = {
      "notify",
      "NvimTree",
      "neo-tree",
      "neo-tree-popup",
      "packer",
      "qf",
      "diff",
      "fugitive",
      "fugitiveblame",
    }
    local disallow_buftypes = {
      "nofile",
      "terminal",
      "help",
    }
    if bo.bt == "" and bo.ft == "" then
      return
    end

    if vim.tbl_contains(disallow_filetypes, bo.ft) or vim.tbl_contains(disallow_buftypes, bo.bt) then
      return
    end

    if winbar.get_bar() == nil then
      winbar.init_winbar(curbuf)
    end
  end,
})

-- convert json to jsonc filetype
vim.cmd([[
  augroup json2jsonc 
  autocmd! FileType json set filetype=jsonc
  augroup END
]])
