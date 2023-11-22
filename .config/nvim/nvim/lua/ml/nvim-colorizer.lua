local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
	vim.notify("colorizer not loaded", vim.log.levels.ERROR, { title = "Initialization (nvim-colorizer)" })
	return
end

colorizer.setup({
	filetypes = { "*" },
	user_default_options = {
		css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
		css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
		-- mode = "virtualtext", -- Set the display mode. [virtualtext, background, foreground]
		mode = "background", -- Set the display mode. [virtualtext, background, foreground]
		-- True is same as normal
		tailwind = true, -- Enable tailwind colors. [false, true, "normal", "lsp", "both"]
		-- sass = true, -- Enable sass colors
		virtualtext = "■",
	},
})
