-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/Mouradost/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/Mouradost/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/Mouradost/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/Mouradost/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/Mouradost/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/Comment.nvim.git",
    url = "git@github.com:numToStr/Comment.nvim"
  },
  ["LuaSnip.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/LuaSnip.git",
    url = "git@github.com:L3MON4D3/LuaSnip"
  },
  ["alpha-nvim.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/alpha-nvim.git",
    url = "git@github.com:goolord/alpha-nvim"
  },
  ["bufferline.nvim.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/bufferline.nvim.git",
    url = "git@github.com:akinsho/bufferline.nvim"
  },
  ["cmp-buffer.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/cmp-buffer.git",
    url = "git@github.com:hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp.git",
    url = "git@github.com:hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua.git",
    url = "git@github.com:hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/cmp-path.git",
    url = "git@github.com:hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "git@github.com:saadparwaiz1/cmp_luasnip"
  },
  ["crates.nvim.git"] = {
    after_files = { "/home/Mouradost/.local/share/nvim/site/pack/packer/opt/crates.nvim.git/after/plugin/cmp_crates.lua" },
    config = { "\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vcrates\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/opt/crates.nvim.git",
    url = "git@github.com:Saecki/crates.nvim"
  },
  ["gitsigns.nvim.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/gitsigns.nvim.git",
    url = "git@github.com:lewis6991/gitsigns.nvim"
  },
  ["impatient.nvim.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/impatient.nvim.git",
    url = "git@github.com:lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim.git",
    url = "git@github.com:lukas-reineke/indent-blankline.nvim"
  },
  ["lazygit.nvim.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/lazygit.nvim.git",
    url = "git@github.com:kdheepak/lazygit.nvim"
  },
  ["lualine.nvim.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/lualine.nvim.git",
    url = "git@github.com:nvim-lualine/lualine.nvim"
  },
  ["mason-lspconfig.nvim.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim.git",
    url = "git@github.com:williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/mason.nvim.git",
    url = "git@github.com:williamboman/mason.nvim"
  },
  ["null-ls.nvim.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/null-ls.nvim.git",
    url = "git@github.com:jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/nvim-autopairs.git",
    url = "git@github.com:windwp/nvim-autopairs"
  },
  ["nvim-cmp.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/nvim-cmp.git",
    url = "git@github.com:hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua.git",
    url = "git@github.com:norcalli/nvim-colorizer.lua"
  },
  ["nvim-dap.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/nvim-dap.git",
    url = "git@github.com:mfussenegger/nvim-dap"
  },
  ["nvim-lspconfig.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/nvim-lspconfig.git",
    url = "git@github.com:neovim/nvim-lspconfig"
  },
  ["nvim-notify.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/nvim-notify.git",
    url = "git@github.com:rcarriga/nvim-notify"
  },
  ["nvim-tree.lua.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/nvim-tree.lua.git",
    url = "git@github.com:kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/nvim-treesitter.git",
    url = "git@github.com:nvim-treesitter/nvim-treesitter"
  },
  ["nvim-ts-context-commentstring.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring.git",
    url = "git@github.com:JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-web-devicons.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/nvim-web-devicons.git",
    url = "git@github.com:kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim.git"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/opt/packer.nvim.git",
    url = "git@github.com:wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["plenary.nvim.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/plenary.nvim.git",
    url = "git@github.com:nvim-lua/plenary.nvim"
  },
  ["project.nvim.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/project.nvim.git",
    url = "git@github.com:ahmedkhalf/project.nvim"
  },
  ["ripgrep.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/ripgrep.git",
    url = "git@github.com:BurntSushi/ripgrep"
  },
  ["rust-tools.nvim.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/rust-tools.nvim.git",
    url = "git@github.com:simrat39/rust-tools.nvim"
  },
  ["telescope-ui-select.nvim.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/telescope-ui-select.nvim.git",
    url = "git@github.com:nvim-telescope/telescope-ui-select.nvim"
  },
  ["telescope.nvim.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/telescope.nvim.git",
    url = "git@github.com:nvim-telescope/telescope.nvim"
  },
  ["toggleterm.nvim.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/toggleterm.nvim.git",
    url = "git@github.com:akinsho/toggleterm.nvim"
  },
  ["tokyonight.nvim.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/tokyonight.nvim.git",
    url = "git@github.com:folke/tokyonight.nvim"
  },
  ["vim-bbye.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/vim-bbye.git",
    url = "git@github.com:moll/vim-bbye"
  },
  ["vim-illuminate.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/vim-illuminate.git",
    url = "git@github.com:RRethy/vim-illuminate"
  },
  ["vimtex.git"] = {
    config = { "\27LJ\2\nœ\1\0\0\2\0\n\0\0216\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\3\0=\1\4\0006\0\0\0009\0\1\0'\1\6\0=\1\5\0006\0\0\0009\0\1\0)\1\0\0=\1\a\0006\0\0\0009\0\1\0'\1\t\0=\1\b\0K\0\1\0\nabdmg\16tex_conceal\25vimtex_quickfix_mode\nlatex\15tex_flavor\23vimtex_view_method\fzathura\31vimtex_view_general_viewer\6g\bvim\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/opt/vimtex.git",
    url = "git@github.com:lervag/vimtex"
  },
  ["which-key.nvim.git"] = {
    loaded = true,
    path = "/home/Mouradost/.local/share/nvim/site/pack/packer/start/which-key.nvim.git",
    url = "git@github.com:folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType tex ++once lua require("packer.load")({'vimtex.git'}, { ft = "tex" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufRead Cargo.toml ++once lua require("packer.load")({'crates.nvim.git'}, { event = "BufRead Cargo.toml" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/Mouradost/.local/share/nvim/site/pack/packer/opt/vimtex.git/ftdetect/cls.vim]], true)
vim.cmd [[source /home/Mouradost/.local/share/nvim/site/pack/packer/opt/vimtex.git/ftdetect/cls.vim]]
time([[Sourcing ftdetect script at: /home/Mouradost/.local/share/nvim/site/pack/packer/opt/vimtex.git/ftdetect/cls.vim]], false)
time([[Sourcing ftdetect script at: /home/Mouradost/.local/share/nvim/site/pack/packer/opt/vimtex.git/ftdetect/tex.vim]], true)
vim.cmd [[source /home/Mouradost/.local/share/nvim/site/pack/packer/opt/vimtex.git/ftdetect/tex.vim]]
time([[Sourcing ftdetect script at: /home/Mouradost/.local/share/nvim/site/pack/packer/opt/vimtex.git/ftdetect/tex.vim]], false)
time([[Sourcing ftdetect script at: /home/Mouradost/.local/share/nvim/site/pack/packer/opt/vimtex.git/ftdetect/tikz.vim]], true)
vim.cmd [[source /home/Mouradost/.local/share/nvim/site/pack/packer/opt/vimtex.git/ftdetect/tikz.vim]]
time([[Sourcing ftdetect script at: /home/Mouradost/.local/share/nvim/site/pack/packer/opt/vimtex.git/ftdetect/tikz.vim]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
