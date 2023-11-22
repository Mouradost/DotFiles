local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	vim.notify("cmp not loaded", vim.log.levels.ERROR, { title = "Initialization" })
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	vim.notify("luasnip not loaded", vim.log.levels.ERROR, { title = "Initialization" })
	return
end

local nvim_cmp_status_ok, nvim_cmp = pcall(require, "cmp")
if not nvim_cmp_status_ok then
	vim.notify("nvim-cmp not loaded", vim.log.levels.ERROR, { title = "Initialization" })
	return
end

local sources = {
	-- { name = "spell" },
	-- { name = "cmp_tabnine" },
	-- { name = "nvim_lua" },
	{ name = "nvim_lsp" },
	{ name = "nvim_lsp_signature_help" },
	{ name = "tailwindcss-colorizer-cmp" },
	{ name = "path" },
	{ name = "luasnip" },
	{ name = "buffer", keyword_length = 4 },
}

for _, source in pairs(sources) do
	-- local status, _ = pcall(require, "ml.cmp.settings." .. source["name"])
	local  --[[ status ]]_, _ = pcall(require, "ml.cmp.settings." .. source["name"])
	-- if not status then
	-- 	vim.notify(
	-- 		"Unable to setup custom configuration! ",
	-- 		vim.log.levels.INFO,
	-- 		{ title = source["name"] }
	-- 	)
	-- end
end

--   פּ ﯟ   some other good icons
local kind_icons = {
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

-- fonction to show the % for tabnine
local show_detail = function(data, name)
	if not data or name ~= "cmp_tabnine" then
		return ""
	end
	local detail = data["detail"]
	if not detail then
		return ""
	end
	if detail and detail:find(".*%%.*") then
		return " " .. data.detail
	end

	if detail.multiline then
		return " " .. "[ML]"
	end
end

local show_colors = function(entry, item)
	if entry == nil or item == nil then
		return item
	end
	local status, tailwindcss = pcall(require, "tailwindcss-colorizer-cmp")
	if not status then
		return item
	end
	return tailwindcss.formatter(entry, item)
end

-- find more here: https://www.nerdfonts.com/cheat-sheet
cmp.setup({
	-- must have at least one snippet engine
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	-- window that shows the auto-completions
	window = {
		documentation = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		},
	},
	-- where to pull from
	sources = cmp.config.sources(sources),
	-- how is the menu displayed
	formatting = {
		fields = { "abbr", "kind", "menu" },
		format = function(entry, vim_item)
			show_colors(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format(
				"%s %s %s",
				kind_icons[vim_item.kind],
				vim_item.kind,
				-- show_colors(entry, vim_item).kind,
				show_detail(entry.completion_item.data, entry.source.name)
			) -- This concatonates the icons with the name of the item kind
			vim_item.menu = ({
				-- spell = "[Spell]",
				-- cmp_tabnine = "[TabNine]",
				nvim_lsp_signature_help = "💡",
				nvim_lsp = "[LSP]",
				nvim_lua = "[lua]",
				luasnip = "[Snip]",
				buffer = "[Buf]",
				path = "[Path]",
			})[entry.source.name]
			return vim_item
		end,
	},
	-- keyboard short cut
	mapping = cmp.mapping.preset.insert({
		["<M-k>"] = cmp.mapping.select_prev_item(),
		["<M-j>"] = cmp.mapping.select_next_item(),
		["<M-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<M-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		--["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<M-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<M-CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
	}),
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	experimental = {
		ghost_text = true,
		native_menu = false,
	},
})

-----------------------------------------
--        Specific completions         --
-----------------------------------------
cmp.setup.filetype("rust", {
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "path" },
	}, {
		{ name = "buffer" },
	}),
})

cmp.setup.filetype("lua", {
	sources = cmp.config.sources({
		{ name = "luasnip" },
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "path" },
	}, {
		{ name = "buffer" },
	}),
})

cmp.setup.filetype("python", {
	sources = cmp.config.sources({
		-- { name = "cmp_tabnine" },
		{ name = "nvim_lsp" },
		{ name = "path" },
	}, {
		{ name = "buffer" },
	}),
})

cmp.setup.filetype("tex", {
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "path" },
		-- { name = "spell" },
	}, {
		{ name = "buffer" },
	}),
})

-- Lazy loading completions for crates in rust
vim.api.nvim_create_autocmd("BufRead", {
	group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
	pattern = "Cargo.toml",
	callback = function()
		cmp.setup.buffer({
			sources = {
				{ name = "crates" },
				{ name = "nvim_lsp" },
				{ name = "path" },
				{ name = "buffer", keyword_length = 4 },
			},
		})
	end,
})
