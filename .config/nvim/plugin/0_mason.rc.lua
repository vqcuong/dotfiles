local status, mason = pcall(require, "mason")
if not status then
	return
end
local status2, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status2 then
	return
end
local status3, mason_nullls = pcall(require, "mason-null-ls")
if not status3 then
	return
end

mason.setup({})

mason_lspconfig.setup({
	ensure_installed = {
		"ansiblels",
		"bashls",
		"dockerls",
		"docker_compose_language_service",
		"jsonls",
		"lua_ls",
		"marksman",
		"pyright",
		"vimls",
		"yamlls",
	},
	automatic_installation = true,
})

mason_nullls.setup({
	ensure_installed = {
		"ansible-lint",
		"jsonlint",
		"luacheck",
		"markdownlint",
		"ruff",
		"shellcheck",
		"yamllint",
		"hadolint",

		"beautysh",
		"black",
		"prettier",
		"stylua",
		"xmlformatter",
		"yamlfmt",
	},
	automatic_installation = true,
})
