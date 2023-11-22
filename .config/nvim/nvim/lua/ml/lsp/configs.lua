local status_ok, mason = pcall(require, "mason")
if not status_ok then
	vim.notify("mason not loaded !", vim.log.levels.ERROR, { title = "Initialization" })
	return
end

local status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status then
	vim.notify("mason-lspconfig not loaded !", vim.log.levels.ERROR, { title = "Initialization" })
	return
end

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	vim.notify("lspconfig not loaded !", vim.log.levels.ERROR, { title = "Initialization" })
end

local servers = {
	"jsonls",
	"lua_ls",
	"pyright",
	"texlab",
	"ltex",
	"rust_analyzer",
	"taplo",
	"bashls",
	"cssls",
	"dockerls",
	"tailwindcss",
	-- "stylelint",
	-- "grammarly",
}

mason.setup({
	-- The directory in which to install packages.
	-- install_root_dir = path.concat({ vim.fn.stdpath("data"), "mason" }),

	-- Where Mason should put its bin location in your PATH. Can be one of:
	-- - "prepend" (default, Mason's bin location is put first in PATH)
	-- - "append" (Mason's bin location is put at the end of PATH)
	-- - "skip" (doesn't modify PATH)
	---@type '"prepend"' | '"append"' | '"skip"'
	PATH = "prepend",
	pip = {
		-- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
		-- and is not recommended.
		--
		-- Example: { "--proxy", "https://proxyserver" }
		install_args = {},
	},
	-- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
	-- debugging issues with package installations.
	log_level = vim.log.levels.INFO,
	-- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
	-- packages that are requested to be installed will be put in a queue.
	max_concurrent_installers = 10,
	github = {
		-- The template URL to use when downloading assets from GitHub.
		-- The placeholders are the following (in order):
		-- 1. The repository (e.g. "rust-lang/rust-analyzer")
		-- 2. The release version (e.g. "v0.3.0")
		-- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
		download_url_template = "https://github.com/%s/releases/download/%s/%s",
	},
	ui = {
		-- Whether to automatically check for new versions when opening the :Mason window.
		check_outdated_packages_on_open = true,
		-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		icons = {
			-- The list icon to use for installed packages.
			package_installed = "✓",
			-- The list icon to use for packages that are installing, or queued for installation.
			package_pending = "➜",
			-- The list icon to use for packages that are not installed.
			package_uninstalled = "✗",
		},
		keymaps = {
			-- Keymap to expand a package
			toggle_package_expand = "<CR>",
			-- Keymap to install the package under the current cursor position
			install_package = "i",
			-- Keymap to reinstall/update the package under the current cursor position
			update_package = "u",
			-- Keymap to check for new version for the package under the current cursor position
			check_package_version = "c",
			-- Keymap to update all installed packages
			update_all_packages = "U",
			-- Keymap to check which installed packages are outdated
			check_outdated_packages = "C",
			-- Keymap to uninstall a package
			uninstall_package = "X",
			-- Keymap to cancel a package installation
			cancel_installation = "<C-c>",
			-- Keymap to apply language filter
			apply_language_filter = "<C-f>",
		},
	},
})

mason_lspconfig.setup({
	-- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "sumneko_lua" }
	-- This setting has no relation with the `automatic_installation` setting.
	ensure_installed = servers,
	-- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
	-- This setting has no relation with the `ensure_installed` setting.
	-- Can either be:
	--   - false: Servers are not automatically installed.
	--   - true: All servers set up via lspconfig are automatically installed.
	--   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
	--       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
	automatic_installation = true,
})

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("ml.lsp.handlers").on_attach,
		capabilities = require("ml.lsp.handlers").capabilities,
	}

	local has_custom_opts, server_custom_opts = pcall(require, "ml.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end
	lspconfig[server].setup(opts)
end
