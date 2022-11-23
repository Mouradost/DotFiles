local notify_status, notify = pcall(require, "notify")
if not notify_status then
	vim.notify("Notify not loaded", vim.log.levels.ERROR, { title = "Initialization" })
	return
end

-- set notify plugin to the global notification channel
vim.notify = notify
