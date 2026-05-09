local enabled = {
  "Wansmer/treesj",

  "smoka7/hop.nvim",
  "kylechui/nvim-surround",
  "iamcco/markdown-preview.nvim",
}

local result = {}
for _, v in pairs(enabled) do
  table.insert(result, { v, vscode = true })
end

return result
