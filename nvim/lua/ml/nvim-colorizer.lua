local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
	vim.notify("colorizer not loaded", vim.log.levels.ERROR, { title = "Initialization" })
	return
end

colorizer.setup()
