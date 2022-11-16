local group = vim.api.nvim_create_augroup("ML_Save_Action", { clear = true })
local pattern = "main.tex"
local current_job = nil
vim.api.nvim_create_autocmd("BufWritePost", {
	group = group,
	pattern = pattern,
	callback = function()
		if not current_job then
			vim.notify("Live preview started !", vim.log.levels.INFO, { title = "My Plugin" })
			current_job =
				vim.fn.jobpid(vim.fn.jobstart("latexmk -pdf -pvc " .. vim.fn.expand("%:p") .. " | zathura -", {
					stdout_buffered = true,
					on_stdout = function(_, data)
						if data then
							vim.notify(
								vim.inspect(vim.pretty_print(data)),
								vim.log.levels.INFO,
								{ title = "My Plugin" }
							)
						end
					end,
					on_stderr = function(_, data)
						if data then
							vim.notify(vim.inspect(data), vim.log.levels.ERROR, { title = "My Plugin" })
						end
					end,
				}))
		end
	end,
})

vim.api.nvim_create_autocmd("ExitPre", {
	group = group,
	pattern = pattern,
	-- command = ":w",
	callback = function()
		if current_job then
			vim.fn.jobstop(current_job)
			vim.notify("Stopping live preview and job " .. current_job, vim.log.levels.WARN, { title = "My Plugin" })
		end
	end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
	group = group,
	pattern = pattern,
	-- command = ":w",
	callback = function()
		vim.api.nvim_command("write")
		vim.notify("Auto saved !", vim.log.levels.INFO, { title = "My Plugin" })
		if current_job then
			vim.fn.jobstop(current_job)
			vim.notify("Stopped job " .. current_job, vim.log.levels.WARN, { title = "My Plugin" })
		end
	end,
})
