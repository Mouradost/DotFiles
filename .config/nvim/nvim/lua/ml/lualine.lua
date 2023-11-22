local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	vim.notify("lualine not loaded", vim.log.levels.ERROR, { title = "Initialization" })
	return
end

---------------------------------------
-- options for the diffrent sections --
---------------------------------------
local lsp = {
	-- Lsp server name .
	function()
		local msg = "No Active Lsp"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return msg
	end,
	icon = " LSP:",
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	colored = true,
	update_in_insert = true,
	always_visible = false,
}

local location = {
	"location",
	padding = 1,
}
---------------------------------------
--       Setup the bottom bar        --
---------------------------------------

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		-- left section
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff" },
		lualine_c = {
			{
				"diagnostics",
				sources = { "nvim_lsp" },
				-- Displays diagnostics for the defined severity types
				sections = { "error", "warn", "info", "hint" },
				diagnostics_color = {
					error = "DiagnosticError", -- Changes diagnostics' error color.
					warn = "DiagnosticWarn", -- Changes diagnostics' warn color.
					info = "DiagnosticInfo", -- Changes diagnostics' info color.
					hint = "DiagnosticHint", -- Changes diagnostics' hint color.
				},
				symbols = { error = "❗", warn = "⚠️ ", info = "💡", hint = "🫠" },
				colored = true, -- Displays diagnostics status in color if set to true.
				update_in_insert = false, -- Update diagnostics in insert mode.
				always_visible = false, -- Show diagnostics even if there are none.
			},
		},
		-- right section
		lualine_x = { lsp, "encoding" },
		lualine_y = { "filetype", "filesize" },
		lualine_z = { location, "progress" },
	},
	inactive_sections = {
		-- left section
		lualine_a = { "hostname" },
		lualine_b = {},
		lualine_c = {},
		-- right section
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
