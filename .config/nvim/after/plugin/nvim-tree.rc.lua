vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


local status, tree = pcall(require, "nvim-tree")
if not status then
  return
end

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  local function add_key(mode, new, func, desc)
    vim.keymap.set(mode, new, func, opts(desc))
  end

  local function del_key(mode, old)
    vim.keymap.del(mode, old, { buffer = bufnr })
  end

  local function replace_key(mode, old, new, func, desc)
    del_key(mode, old)
    add_key(mode, new, func, desc)
  end

  -- custom mappings
  -- add_key('n', '<Left>', api.tree.change_root_to_parent, 'Change Root To Parent')
  -- add_key('n', '<Right>', api.tree.change_root_to_node, 'Change Root To Node')
  replace_key('n', 'g?', '?', api.tree.toggle_help, 'Help')
  add_key('n', 'zz', api.tree.focus, 'Focus')
  add_key('n', 'tt', api.tree.toggle, 'Toggle')
end

tree.setup({
  on_attach = my_on_attach,
})

