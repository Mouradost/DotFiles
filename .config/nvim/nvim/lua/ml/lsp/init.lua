local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	vim.notify("Problem initializing lsp", vim.log.levels.ERROR, { title = "Initialization" })
	return
end

require("ml.lsp.configs")
require("ml.lsp.handlers").setup()
require("ml.lsp.null-ls")
