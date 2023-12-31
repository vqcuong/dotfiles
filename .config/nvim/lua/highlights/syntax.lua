local api = vim.api
api.nvim_set_hl(0, "@variable.builtin", { fg = "#0dff00", bold = true })
api.nvim_set_hl(0, "@function.builtin", { fg = "#00b3ff", bold = true })
api.nvim_set_hl(0, "@parameter", { fg = "#00fffb", italic = true })
api.nvim_set_hl(0, "@property", { fg = "#ff80dd", italic = true })
api.nvim_set_hl(0, "@field", { fg = "#ff80dd", italic = true })
-- api.nvim_set_hl(0, "@namespace", { fg = "#ff4089", italic = true })

api.nvim_set_hl(0, "Search", { bg = "#445566" })
api.nvim_set_hl(0, "CurSearch", { bg = "#ffffff", fg = "#ff795e" })
api.nvim_set_hl(0, "IncSearch", { bg = "#ffffff", fg = "#00a2ff" })
