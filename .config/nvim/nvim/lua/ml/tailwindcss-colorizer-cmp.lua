local status_ok, colorizer = pcall(require, "tailwindcss-colorizer-cmp")
if not status_ok then
	vim.notify(
		"tailwindcss-colorizer-cmp not loaded",
		vim.log.levels.ERROR,
		{ title = "Initialization (tailwindcss-colorizer-cmp)" }
	)
	return
end

colorizer.setup({
	filetypes = { "*" },
	color_square_width = 2,
})
