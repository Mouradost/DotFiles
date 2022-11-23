vim.cmd([[
try
colorscheme tokyonight-night
catch /^Vim\%((\a\+)\)\=:E185/
colorscheme default
set background=dark
endtry
]])
