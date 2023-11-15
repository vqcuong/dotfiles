-- disable auto comment when insert new line after comment
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("FormatOptions", {}),
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove({ "r", "o" })
  end,
})

-- instantly hide diagnostic when entering insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
  group = vim.api.nvim_create_augroup("HideDiagnostic", {}),
  pattern = "*",
  callback = function()
    vim.diagnostic.hide(nil, 0)
  end,
})

-- instantly show diagnostic when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  group = vim.api.nvim_create_augroup("ShowDiagnostic", {}),
  pattern = "*",
  callback = function()
    vim.diagnostic.show(nil, 0)
  end,
})

-- disable paste when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})
