local status_ok, indent_blankline = pcall(require, "ibl")
if not status_ok then
	vim.notify("indent_blankline not loaded", vim.log.levels.ERROR, { title = "Initialization" })
	return
end
local status_hooks_ok, hooks = pcall(require, "ibl.hooks")
if not status_hooks_ok then
	vim.notify("indent_blankline.Hooks not loaded", vim.log.levels.ERROR, { title = "Initialization" })
	return
end

local highlight = {
	"RainbowRed",
	"RainbowYellow",
	"RainbowBlue",
	"RainbowOrange",
	"RainbowGreen",
	"RainbowViolet",
	"RainbowCyan",
}

-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

indent_blankline.setup({
	indent = { highlight = highlight, char = "▏" },
	exclude = {
		filetypes = {
			"help",
			"startify",
			"dashboard",
			"packer",
			"neogitstatus",
			"NvimTree",
			"Trouble",
		},
		buftypes = { "terminal", "nofile" },
	},
	whitespace = {
		highlight = highlight,
		remove_blankline_trail = true,
	},
	scope = {
		enabled = true,
		highlight = highlight,
		show_start = true,
		show_end = true,
		injected_languages = true,
		-- priority = 500,
		include = {
			node_type = {
				["*"] = {
					"class",
					"return",
					"function",
					"method",
					"^if",
					"^while",
					"jsx_element",
					"^for",
					"^object",
					"^table",
					"block",
					"arguments",
					"if_statement",
					"else_clause",
					"jsx_element",
					"jsx_self_closing_element",
					"try_statement",
					"catch_clause",
					"import_statement",
					"operation_type",
				},
			},
		},
	},
})
