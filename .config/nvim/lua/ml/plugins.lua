------------------------------------
--	  INITIALIZATION	  --
------------------------------------

local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- auto install packer (the package manager)
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"git@github.com:wbthomason/packer.nvim.git",
		install_path,
	})
	vim.notify("Installing packer... Please restart Neovim", vim.log.levels.INFO)
	vim.cmd([[packadd packer.nvim]])
end

-- Live reload for this file after saving
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

------------------------------------
--	   PACKER IMPORT	  --
------------------------------------

-- import packer with a protected call
local status, packer = pcall(require, "packer")
if not status then
	vim.notify("Packer don't exist!", vim.log.levels.ERROR, { title = "Initialization" }) -- We could show the packer variable since it holds the error message
	return
end

-- Set a pop-up window for packer
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

------------------------------------
--	PLUGINS INSTALLATION	  --
------------------------------------

return packer.startup(function(use)
	-- To download a pluggin just add its github ssh address here
	-- We use ssh because it's less prome to errors and can bypass the chinese firewall
	-- Packer itself
	use({ "git@github.com:wbthomason/packer.nvim.git", opt = true }) -- We can specify a specific commit by commit="commit_id"

	-- Essentials
	use({ "git@github.com:nvim-lua/plenary.nvim.git" }) -- Used by telescope and many pluggins
	use({ "git@github.com:lewis6991/impatient.nvim.git" }) -- Speed-up statup time and pluggins load
	use({ "git@github.com:moll/vim-bbye.git" }) -- Delete buffers and close files without closing window

	-- Search
	-- The following two plugins are installed by dnf
	-- use({"git@github.com:BurntSushi/ripgrep.git"}) -- inline search used by telescope (rust)
	-- use({"git@github.com:sharkdp/fd.git"}) -- used by telescope same as find but faster
	use({
		"git@github.com:nvim-telescope/telescope.nvim.git",
		requires = { "git@github.com:BurntSushi/ripgrep.git", "git@github.com:nvim-lua/plenary.nvim.git" },
	}) -- Search engien Telescope

	-- Colorscheme
	use({ "git@github.com:folke/tokyonight.nvim.git" }) -- Theme tokyonight

	-- Highlight
	use({ "git@github.com:nvim-treesitter/nvim-treesitter.git", run = ":TSUpdate" }) -- Code highlight
	-- use({"git@github.com:nvim-treesitter/nvim-treesitter.git", run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,}) -- if treesitter fail try this

	-- Code completion
	use({ "git@github.com:hrsh7th/cmp-buffer.git" }) -- cmp buff for faster completion
	use({ "git@github.com:hrsh7th/cmp-path.git" }) -- path completion
	use({ "git@github.com:hrsh7th/cmp-nvim-lsp.git" }) -- LSP completion
	use({ "git@github.com:hrsh7th/cmp-nvim-lua.git" }) -- Lua completion
	use({ "git@github.com:saadparwaiz1/cmp_luasnip" }) -- lua snippet
	use({ "git@github.com:hrsh7th/nvim-cmp.git" }) -- cmp pluggin essential for completion

	-- Latex

	use({
		"git@github.com:lervag/vimtex.git",
		opt = true,
		config = function()
			vim.g.vimtex_view_general_viewer = "zathura"
			vim.g.vimtex_view_method = "zathura"
			vim.g.tex_flavor = "latex"
			vim.g.vimtex_quickfix_mode = 0
			vim.g.tex_conceal = "abdmg"
		end,
		ft = "tex",
		conceallevel = 1,
	}) -- latex support but not written in lua and no treesitter
	--use({ "git@github.com:kdheepak/cmp-latex-symbols.git" }) -- latex symbols code completion

	-- LSP (Language Support Provider)
	-- use({ "git@github.com:williamboman/nvim-lsp-installer" }) -- LSP server installer (depricated use mason instead)
	use({ "git@github.com:williamboman/mason.nvim.git" }) -- LSP server Installer
	use({ "git@github.com:williamboman/mason-lspconfig.nvim.git" }) -- mason helper for lspconfig.
	use({ "git@github.com:neovim/nvim-lspconfig.git" }) -- LSP configuration essential for all the LSPs
	use({ "git@github.com:jose-elias-alvarez/null-ls.nvim.git" }) -- For formatters and linters
	-- use({
	-- 	"git@github.com:tzachar/cmp-tabnine",
	-- 	after = "nvim-cmp",
	-- 	run = "./install.sh",
	-- 	requires = "hrsh7th/nvim-cmp",
	-- }) -- Tabnine

	-- Debugging
	use({ "git@github.com:mfussenegger/nvim-dap.git" }) -- allow debugging and is fast need to be configured for each language

	-- Snippets
	use({ "git@github.com:L3MON4D3/LuaSnip.git" }) -- lua snippet

	-- Git
	use({ "git@github.com:lewis6991/gitsigns.nvim.git" }) -- git info like vscode
	use({ "git@github.com:kdheepak/lazygit.nvim.git" }) -- UI like experience for git

	-- Rust
	use({ "git@github.com:simrat39/rust-tools.nvim.git" })

	-- Color highlight
	use({ "git@github.com:norcalli/nvim-colorizer.lua.git" }) -- fast color highlight (show the color like this #FFFFFF)

	-- UI
	use({ "git@github.com:akinsho/bufferline.nvim.git" }) -- GUI like aesthetic
	use({ "git@github.com:akinsho/toggleterm.nvim.git" }) -- allow multi-window
	use({ "git@github.com:kyazdani42/nvim-web-devicons.git" }) -- icons
	use({ "git@github.com:kyazdani42/nvim-tree.lua.git" }) -- tree view for folders and files
	use({ "git@github.com:goolord/alpha-nvim.git" }) -- home page
	use({ "git@github.com:rcarriga/nvim-notify.git" }) -- notifications pop-up
	use({ "git@github.com:nvim-telescope/telescope-ui-select.nvim.git" }) -- set vim.ui.select to telescope

	-- Utilities
	use({ "git@github.com:windwp/nvim-autopairs.git" }) -- autopairs [()]
	use({ "git@github.com:JoosepAlviste/nvim-ts-context-commentstring.git" }) -- comment based on the file extention
	use({ "git@github.com:numToStr/Comment.nvim.git" }) -- language awair comment tool
	use({ "git@github.com:folke/which-key.nvim.git" }) -- show shortcuts and keybindings
	use({ "git@github.com:RRethy/vim-illuminate.git" }) -- Highlight the current word and its occurences
	use({ "git@github.com:nvim-lualine/lualine.nvim.git" }) -- status bar
	use({ "git@github.com:ahmedkhalf/project.nvim.git" }) --handle project like an ide
	use({ "git@github.com:lukas-reineke/indent-blankline.nvim.git" })

	-- use({ "git@github.com:dstein64/vim-startuptime.git" }) -- Profiling the startup time

	-- We check it this was the first time we install packer
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
