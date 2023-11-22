-- import packer with a protected call
local status, vimtex = pcall(require, "vimtex")
if not status then
  vim.notify("vimtex don't exist!", vim.log.levels.ERROR, { title = "Initialization" })
  return
end

local function config()
  vim.g.vimtex_view_general_viewer = "zathura"
  vim.g.vimtex_view_method = "zathura"
  vim.g.tex_flavor = "latex"
  vim.g.vimtex_quickfix_mode = 0
  vim.g.tex_conceal = "abdmg"
end

vimtex.setup({
  opt = true,
  config = config,
  ft = "tex",
  conceallevel = 1,
})
