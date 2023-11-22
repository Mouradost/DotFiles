vim.api.nvim_create_autocmd("DiagnosticChanged", {
	callback = function(args)
		local diagnostics = args.data.diagnostics
		vim.pretty_print(diagnostics)
		vim.notify(vim.inspect(diagnostics))
	end,
})
