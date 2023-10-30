local status, saga = pcall(require, "lspsaga")
if (not status) then return end

saga.setup({
  symbol_in_winbar = {
    enable = true,
    folder_level = 3
  },
  code_action = {
    enable = true,
  },
  diagnostic = {
    show_code_action = true,
  },
  definition = {
    keys = {
      edit = "e",
      vsplit = "v",
      split = "h",
      tabe = "t",
      quit = "q",
      close = "q"
    }
  },
  finder = {
    keys = {
      vsplit = "v",
      split = "h",
      tabe = "t",
      tabnew = "r",
      quit = "q",
      close = "q"
    }
  },
  outline = {
    close_after_jump = true,
    keys = {
      jump = "j"
    }
  },
  rename = {
    keys = {
      quit = "q",
    }
  },
  lightbulb = {
    sign = false,
  }
})

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', 'gl', '<Cmd>Lspsaga show_line_diagnostics<CR>', opts)
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.keymap.set('n', 'gf', '<Cmd>Lspsaga finder<CR>', opts)
vim.keymap.set('n', 'gt', '<Cmd>Lspsaga goto_type_definition<CR>', opts)
-- vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
vim.keymap.set('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)

-- code action
vim.keymap.set({ "n", "v" }, "ga", "<cmd>Lspsaga code_action<CR>")
