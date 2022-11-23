--------------------------------------------
----             Boilerplate            ----
--------------------------------------------

local status, ls = pcall(require, "luasnip")
if not status then
	vim.notify("Luasnip not loaded !", vim.log.levels.ERROR, { title = "Snippets Latex" })
	return
end

local group = vim.api.nvim_create_augroup("Lua Snippets", { clear = true })
local target = "*.tex"

local s = ls.s --> snippet
local i = ls.i --> insert node
local t = ls.t --> text node

local d = ls.dynamic_node -->
local c = ls.choice_node -->
local f = ls.function_node -->
local sn = ls.snippet_node -->

local fmt = require("luasnip.extras.fmt").ftm -->
local rep = require("luasnip.extras").rep -->

local snippets, autosnippets = {}, {}

--------------------------------------------
----             Snippets              -----
--------------------------------------------

local my_fisrt_snippet = s("my_fisrt_snippet", { t("Hi this is awsome!") })
table.insert(snippets, my_fisrt_snippet)

local begin = s("begin", {
	t("begin{"),
	i(1, "..."),
	t({ "}", "" }),
	i(2, ""),
	t({ "", "end" }),
})
table.insert(snippets, begin)

return snippets, autosnippets
