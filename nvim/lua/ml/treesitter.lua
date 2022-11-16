local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	vim.notify("treesitter not loaded", vim.log.levels.ERROR, { title = "Initialization" })
	return
end

configs.setup({
	ensure_installed = "all", -- one of "all" or a list of languages
	sync_install = false,
	auto_install = true,
	ignore_install = {}, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "latex" }, -- disable for latex so that the vimtex work
		additional_vim_regex_highlighting = false, -- slow but essential if plug needs syntax to indent
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true },
})
