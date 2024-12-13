local lazyvimUtil = require("lazyvim.util")
local lazyvimConfig = require("lazyvim.config")

return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    config = function()
      local tree = require("nvim-tree")

      local function my_on_attach(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        -- api.config.mappings.default_on_attach(bufnr)

        local function add_key(mode, new, func, desc)
          vim.keymap.set(mode, new, func, opts(desc))
        end

        -- local function del_key(mode, old)
        --   vim.keymap.del(mode, old, { buffer = bufnr })
        -- end
        --
        -- local function replace_key(mode, old, new, func, desc)
        --   del_key(mode, old)
        --   add_key(mode, new, func, desc)
        -- end

        -- custom mappings
        add_key("n", "?", api.tree.toggle_help, "Show helps")
        add_key("n", "<s-left>", api.tree.change_root_to_parent, "Up")
        add_key("n", "<s-right>", api.tree.change_root_to_node, "Cd")
        add_key("n", "gm", api.tree.toggle_git_clean_filter, "Toggle git modified")
        add_key("n", "gi", api.tree.toggle_gitignore_filter, "Toggle git ignored")
        add_key("n", "e", api.tree.expand_all, "Expand all")
        add_key("n", "w", api.tree.collapse_all, "Collapse all")
        add_key("n", "q", api.tree.close, "Quit")
        add_key("n", "R", api.tree.reload, "Refresh")
        add_key("n", "S", api.tree.search_node, "Search")
        add_key("n", "H", api.tree.toggle_hidden_filter, "Toggle hidden")
        add_key("n", "B", api.tree.toggle_no_buffer_filter, "Toggle buffers")
        add_key("n", "U", api.tree.toggle_custom_filter, "Toggle custom filter")

        add_key("n", "<cr>", api.node.open.edit, "Open")
        add_key("n", "<tab>", api.node.open.preview, "Preview")
        add_key("n", "<right>", api.node.open.preview, "Preview")
        add_key("n", "<left>", api.node.navigate.parent, "Goto parent")
        add_key("n", "<bs>", api.node.navigate.parent_close, "Close Dir")
        add_key("n", "i", api.node.show_info_popup, "Show info")
        add_key("n", "o", api.node.open.replace_tree_buffer, "Open in place")
        add_key("n", "t", api.node.open.tab, "Open in new tab")
        add_key("n", "v", api.node.open.vertical, "Open vertically")
        add_key("n", "h", api.node.open.horizontal, "Open horizontally")
        add_key("n", "<", api.node.navigate.sibling.prev, "Prev sibling")
        add_key("n", ">", api.node.navigate.sibling.next, "Next sibling")
        add_key("n", "[c", api.node.navigate.git.prev, "Prev git")
        add_key("n", "]c", api.node.navigate.git.next, "Next git")
        add_key("n", "[e", api.node.navigate.diagnostics.prev, "Prev diagnostic")
        add_key("n", "]e", api.node.navigate.diagnostics.next, "Next diagnostic")
        add_key("n", "k", api.node.navigate.sibling.first, "First sibling")
        add_key("n", "j", api.node.navigate.sibling.last, "Last sibling")
        add_key("n", "O", api.node.run.system, "Open with vscode")
        add_key("n", ".", api.node.run.cmd, "Run command")

        add_key("n", "n", api.fs.create, "New")
        add_key("n", "c", api.fs.copy.node, "Copy")
        add_key("n", "gp", api.fs.copy.absolute_path, "Copy absolute path")
        add_key("n", "gr", api.fs.copy.relative_path, "Copy relative path")
        add_key("n", "gf", api.fs.copy.filename, "Copy file name")
        add_key("n", "r", api.fs.rename, "Rename")
        add_key("n", "b", api.fs.rename_basename, "Rename base")
        add_key("n", "x", api.fs.cut, "Cut")
        add_key("n", "p", api.fs.paste, "Paste")
        add_key("n", "D", api.fs.remove, "Delete")
        add_key("n", "T", api.fs.trash, "Trash")
        add_key("n", "X", api.fs.clear_clipboard, "Clear clipboard")

        add_key("n", "md", api.marks.bulk.delete, "Delete bookmarked")
        add_key("n", "mt", api.marks.bulk.trash, "Trash bookmarked")
        add_key("n", "mv", api.marks.bulk.move, "Move bookmarked")
        add_key("n", "mm", api.marks.toggle, "Toggle bookmark")

        add_key("n", "gl", api.git.reload, "Git reload")

        -- add_key("n", "F", api.live_filter.clear, "Clean Filter")
        -- add_key("n", "f", api.live_filter.start, "Filter")
      end
      tree.setup({
        on_attach = my_on_attach,
        view = {
          signcolumn = "no",
          width = {
            min = 20,
            max = 30,
            padding = 0,
          },
          float = {
            enable = false,
          },
        },
        filters = {
          dotfiles = false,
          custom = { "^.git$", "__pycache__" },
          exclude = { ".gitignore" },
        },
        renderer = {
          full_name = true,
          root_folder_label = ":~:s?$?",
          highlight_opened_files = "icon",
          highlight_modified = "name",
          indent_markers = {
            enable = true,
          },
        },
        update_focused_file = {
          enable = true,
        },
        system_open = {
          cmd = "code",
        },
        actions = {
          expand_all = {
            exclude = { ".git", ".vscode", ".idea", ".github", "__pycache__" },
          },
          open_file = {
            window_picker = {
              enable = true,
              -- picker = window_picker,
              chars = "QWERTYUIOPASDFGHJKLZXCVBNM1234567890",
              exclude = {
                filetype = {
                  "notify",
                  "NvimTree",
                  "neo-tree",
                  "neo-tree-popup",
                  "packer",
                  "qf",
                  "diff",
                  "fugitive",
                  "fugitiveblame",
                },
                buftype = {
                  "nofile",
                  "terminal",
                  "help",
                },
              },
            },
          },
        },
      })

      require("which-key").add({
        { "<leader>d", group = "File Explorer" },
        { "<leader>df", "<cmd>NvimTreeFocus<cr>", desc = "Focus" },
        { "<leader>dg", "<cmd>lua require('nvim-tree.api').git.reload()<cr>", desc = "Git reload" },
        { "<leader>de", "<cmd>NvimTreeToggle<cr>", desc = "Toggle" },
        { "<leader>dc", "<cmd>NvimTreeClipboard<cr>", desc = "Show clipboard" },
        { "<leader>dx", "<cmd>lua require('nvim-tree.api').fs.clear_clipboard()<cr>", desc = "Clear clipboard" },
        { "<localleader>e", "<leader>df", desc = "Explorer focus", remap = true },
        { "<localleader><localleader>", "<leader>de", desc = "Explorer toggle", remap = true },
      })
    end,
  },

  {
    "folke/flash.nvim",
    keys = function()
      -- stylua: ignore
      return {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" }
      }
    end,
  },

  {
    "phaazon/hop.nvim",
    event = "VeryLazy",
    -- stylua: ignore
    keys = {
      { "f", function() require("hop").hint_char1() end, remap = true },
      { "F", function() require("hop").hint_char2() end, remap = true },
      { "A", function() require("hop").hint_lines_skip_whitespace() end, remap = true },
      { "P", function() require("hop").hint_patterns() end, remap = true },
    },
    config = function()
      local positions = require("hop.hint").HintPosition
      require("hop").setup({ hint_position = positions.END })
    end,
  },

  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<localleader>x", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<localleader>X", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
    },
  },

  {
    "folke/todo-comments.nvim",
    -- stylua: ignore
    keys = {
      { "<localleader>t", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      { "<localleader>T", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
    },
    opts = {
      search = {
        pattern = [[#( )*(KEYWORDS)\b]],
      },
    },
  },

  {
    "sontungexpt/stcursorword",
    event = "VeryLazy",
    opts = {
      highlight = {
        underline = false,
        bg = "#44515e",
      },
    },
    config = true,
  },

  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>h", group = "helps" },
      },
    },
  },

  {
    "ibhagwan/fzf-lua",
    keys = function()
      local function symbols_filter(entry, ctx)
        if ctx.symbols_filter == nil then
          ctx.symbols_filter = LazyVim.config.get_kind_filter(ctx.bufnr) or false
        end
        if ctx.symbols_filter == false then
          return true
        end
        return vim.tbl_contains(ctx.symbols_filter, entry.kind)
      end

      return {
        { "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
        { "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },

        -- find
        { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
        { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
        { "<leader>ff", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
        { "<leader>fF", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
        { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
        { "<leader>fR", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
        -- git
        { "<leader>gf", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
        { "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Commits" },
        { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Status" },
        -- search
        { "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer" },
        { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
        { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
        { "<leader>sg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
        { "<leader>sG", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
        { "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
        { "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
        { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
        { "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
        { "<leader>sw", LazyVim.pick("grep_cword"), desc = "Word (Root Dir)" },
        { "<leader>sW", LazyVim.pick("grep_cword", { root = false }), desc = "Word (cwd)" },
        { "<leader>sw", LazyVim.pick("grep_visual"), mode = "v", desc = "Selection (Root Dir)" },
        { "<leader>sW", LazyVim.pick("grep_visual", { root = false }), mode = "v", desc = "Selection (cwd)" },
        {
          "<leader>ss",
          function()
            require("fzf-lua").lsp_document_symbols({
              regex_filter = symbols_filter,
            })
          end,
          desc = "Goto Symbol",
        },
        {
          "<leader>sS",
          function()
            require("fzf-lua").lsp_live_workspace_symbols({
              regex_filter = symbols_filter,
            })
          end,
          desc = "Goto Symbol (Workspace)",
        },

        { "<leader>ha", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
        { "<leader>hc", "<cmd>FzfLua commands<cr>", desc = "Commands" },
        { "<leader>hC", LazyVim.pick("colorschemes"), desc = "Colorscheme with Preview" },
        { "<leader>hh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
        { "<leader>hl", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
        { "<leader>hk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
        { "<leader>hm", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },

        -- stylua: ignored
        { "<leader>.", "<cmd>FzfLua resume<cr>", desc = "Resume" },
        { "<leader>'", "<cmd>FzfLua registers<cr>", desc = "Registers" },
        { "<leader>,", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Switch Buffer" },
        { "<leader>/", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
        { "<leader>G", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
        { "<leader>;", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
        { "<leader><space>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      }
    end,
  },
}
