local status, fterm = pcall(require, "FTerm")
if not status then
  return
end

fterm.setup({
  border = 'double',
  dimensions = {
    height = 0.9,
    width = 0.9,
  },
})

local function opts(desc)
  return { desc = "FTerm: " .. desc }
end

vim.keymap.set('n', '<leader>t', function() require("FTerm").toggle() end, opts("Toggle"))
vim.keymap.set('t', '<leader>t', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts("Toggle"))
