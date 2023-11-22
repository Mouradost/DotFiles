vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  augroup _latex
    autocmd!
    autocmd FileType latex setlocal wrap
    autocmd FileType latex setlocal spell
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

]])
-- local _general_settings = vim.api.nvim_create_augroup("_general_settings", { clear = true })
--
-- vim.api.nvim_create_autocmd("InsertLeave", {
-- 	group = _general_settings,
-- 	pattern = "qf,help,man,lspinfo",
-- 	callback = function() end,
-- })
-- vim.api.nvim_create_autocmd("InsertLeave", {
-- 	group = _general_settings,
-- 	pattern = "*",
-- 	callback = function() end,
-- })
-- vim.api.nvim_create_autocmd("InsertLeave", {
-- 	group = _general_settings,
-- 	pattern = "qf,help,man,lspinfo",
-- 	callback = function() end,
-- })
--
-- local _git = vim.api.nvim_create_augroup("_git", { clear = true })
--
-- vim.api.nvim_create_autocmd("FileType", {
-- 	group = _git,
-- 	pattern = "gitcommit",
-- 	callback = function() end,
-- })
--
-- local _markdown = vim.api.nvim_create_augroup("_markdown", { clear = true })
--
-- vim.api.nvim_create_autocmd("FileType", {
-- 	group = _markdown,
-- 	pattern = "markdown",
-- 	callback = function() end,
-- })
--
-- local _auto_resize = vim.api.nvim_create_augroup("_auto_resize", { clear = true })
--
-- vim.api.nvim_create_autocmd("VimResized", {
-- 	group = _auto_resize,
-- 	pattern = "*",
-- 	callback = function() end,
-- })
--
-- local _alpha = vim.api.nvim_create_augroup("_alpha", { clear = true })
--
-- vim.api.nvim_create_autocmd("User", {
-- 	group = _alpha,
-- 	pattern = "AlphaReady",
-- 	callback = function() end,
-- })
