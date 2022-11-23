local status_ok, impatient = pcall(require, "impatient")
if not status_ok then
	vim.notify("impatient not loaded", vim.log.levels.ERROR, { title = "Initialization" })
	return
end

impatient.enable_profile()
