local enabled = {
  "Wansmer/treesj",

  "phaazon/hop.nvim",
  "kylechui/nvim-surround",
  "iamcco/markdown-preview.nvim",
}

local result = {}
for _, v in pairs(enabled) do
  table.insert(result, { v, vscode = true })
end

return result
