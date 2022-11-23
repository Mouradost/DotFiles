local msg

-- how to declare a function
local function test(text)
	vim.notify(text, vim.log.levels.INFO, { title = "My plug" })
end

msg = vim.fn.getcwd()

test(msg)

-- Data structure
local array = { "test", "test2" }
test(array)

local dict = {
	["test"] = "this is test",
	["test2"] = "this is test 2",
}

-- for loops
for k, v in pairs(dict) do
	test(k)
	test(v)
end

local lspconfig = require("lspconfig")

for k, v in pairs(lspconfig.util.defaultconfig) do
	test(k)
	test(v)
end
