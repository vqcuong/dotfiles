vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local status, tree = pcall(require, "nvim-tree")
if not status then
  return
end

local status2, wp = pcall(require, "window-picker")
if not status2 then
  return
end

wp.setup({
  show_prompt = false,
  bo = {
    filetype = { "NvimTree", "neo-tree", "notify", "packer", "Mason", "fugitive", "fugitiveblame" },
    buftype = { 'terminal', "nofile", "help" },
  },
})

local function window_picker()
  local status, wp = pcall(require, "window-picker")
  if not status then
    print("You'll need to install window-picker before use this command")
    return "default"
  else
    local picked_window_id = wp.pick_window({ hint = "floating-big-letter" })
    if picked_window_id then
      vim.api.nvim_set_current_win(picked_window_id)
      return picked_window_id
    end
    return "default"
  end
end

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "Nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
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
  replace_key('n', '<C-]>', '<Left>', api.tree.change_root_to_parent, 'Up')
  replace_key('n', '-', '<Right>', api.tree.change_root_to_node, 'CD')
  replace_key('n', 'g?', '?', api.tree.toggle_help, 'Help')
  replace_key('n', '<C-v>', 'vv', api.node.open.vertical, 'Open File - split vertically')
  replace_key('n', '<C-x>', 'hh', api.node.open.horizontal, 'Open File - split horizontally')
  replace_key('n', 'a', 'nn', api.fs.create, 'New')
  replace_key('n', 'c', 'cc', api.fs.copy.node, 'Copy')
  replace_key('n', 'gy', 'cp', api.fs.copy.absolute_path, 'Copy Absolute Path')
  replace_key('n', 'Y', 'cr', api.fs.copy.relative_path, 'Copy Relative Path')
  replace_key('n', 'y', 'cn', api.fs.copy.filename, 'Copy File Name')
  replace_key('n', 'r', 'rr', api.fs.rename, 'Rename')
  replace_key('n', 'e', 'rb', api.fs.rename_basename, 'Rename')
  replace_key('n', 'x', 'xx', api.fs.cut, 'Cut')
  replace_key('n', 'p', 'pp', api.fs.paste, 'Paste')
  replace_key('n', 'd', 'dd', api.fs.remove, 'Delete')
  replace_key('n', 'D', 'dt', api.fs.trash, 'Trash')
  replace_key('n', '<C-k>', 'ii', api.node.show_info_popup, 'Get Info')
  replace_key('n', 'C', 'gg', api.tree.toggle_git_clean_filter, 'Git Clean Filter')
  replace_key('n', 'I', 'gi', api.tree.toggle_gitignore_filter, 'Git Ignore Filter')
  del_key('n', '<C-r>')
  del_key('n', 'u')
  -- add_key('n', 'zz', api.tree.focus, 'Focus')
  -- add_key('n', 'tt', api.tree.toggle, 'Toggle')
end

tree.setup({
  on_attach = my_on_attach,
  actions = {
    open_file = {
      window_picker = {
        enable = true,
        -- picker = window_picker,
        chars = "QWERTYUIOPASDFGHJKLZXCVBNM1234567890"
      }
    }
  }
})

local function opts(desc)
  return { desc = "Nvim-tree: " .. desc, noremap = true, silent = true, nowait = true }
end

vim.keymap.set('n', 'G', '<CMD>lua require("nvim-tree.api").git.reload()<CR>', opts("Git Reload"))
vim.keymap.set('n', 'zz', '<CMD>NvimTreeFocus<CR>', opts("Focus"))
vim.keymap.set('n', 'tt', '<CMD>NvimTreeToggle<CR>', opts("Toggle"))
vim.keymap.set('n', 'bb', '<CMD>NvimTreeClipboard<CR>', opts("Show Clipboard"))
vim.keymap.set('n', 'bc', '<CMD>lua require("nvim-tree.api").fs.clear_clipboard()<CR>', opts("Clear Clipboard"))
vim.keymap.set('n', 'ww', '<CMD>lua require("window-picker").pick_window({hint = "floating-big-letter"})<CR>')
