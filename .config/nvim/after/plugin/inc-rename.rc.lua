local status, rename = pcall(require, "inc_rename")
if not status then
  return
end

rename.setup({
	cmd_name = "IncRename",
  hl_group = "Substitute",
  preview_empty_name = false,
	show_message = false,
	input_buffer_type = nil,
  post_hook = nil, 

})
-- vim.keymap.set("n", "<leader>e", ":IncRename ", {desc = "Rename"})

vim.keymap.set("n", "<leader>e", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { desc = "Rename", expr = true })
