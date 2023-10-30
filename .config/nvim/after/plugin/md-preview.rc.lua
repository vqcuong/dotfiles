local function opts(desc)
  return { desc = desc, silent = true }
end
vim.keymap.set('n', 'md', "<CMD>MarkdownPreview<CR>", opts("Markdown Preview"))
