--- ### mlnvim LSP
--
-- This module is automatically loaded by mlnvim on during it's initialization into global variable `mlnvim.lsp`
--
-- This module can also be manually loaded with `local updater = require("core.utils").lsp`
--
-- @module core.utils.lsp
-- @see core.utils
-- @copyright 2022
-- @license GNU General Public License v3.0

mlnvim.lsp = {}
local tbl_contains = vim.tbl_contains
local tbl_isempty = vim.tbl_isempty
local user_plugin_opts = mlnvim.user_plugin_opts
local conditional_func = mlnvim.conditional_func
local user_registration = user_plugin_opts("lsp.server_registration", nil, false)
local skip_setup = user_plugin_opts("lsp.skip_setup")

mlnvim.lsp.formatting = mlnvim.user_plugin_opts("lsp.formatting", { format_on_save = { enabled = true } })
if type(mlnvim.lsp.formatting.format_on_save) == "boolean" then
	mlnvim.lsp.formatting.format_on_save = { enabled = mlnvim.lsp.formatting.format_on_save }
end

mlnvim.lsp.format_opts = vim.deepcopy(mlnvim.lsp.formatting)
mlnvim.lsp.format_opts.disabled = nil
mlnvim.lsp.format_opts.format_on_save = nil
mlnvim.lsp.format_opts.filter = function(client)
	local filter = mlnvim.lsp.formatting.filter
	local disabled = mlnvim.lsp.formatting.disabled or {}
	-- check if client is fully disabled or filtered by function
	return not (vim.tbl_contains(disabled, client.name) or (type(filter) == "function" and not filter(client)))
end

--- Helper function to set up a given server with the Neovim LSP client
-- @param server the name of the server to be setup
mlnvim.lsp.setup = function(server)
	if not tbl_contains(skip_setup, server) then
		local opts = mlnvim.lsp.server_settings(server)
		if type(user_registration) == "function" then
			user_registration(server, opts)
		else
			require("lspconfig")[server].setup(opts)
		end
	end
end

--- The `on_attach` function used by mlnvim
-- @param client the LSP client details when attaching
-- @param bufnr the number of the buffer that the LSP client is attaching to
mlnvim.lsp.on_attach =
	function(client, bufnr)
		local capabilities = client.server_capabilities
		local lsp_mappings = {
			n = {
				["<leader>ld"] = {
					function()
						vim.diagnostic.open_float()
					end,
					desc = "Hover diagnostics",
				},
				["[d"] = {
					function()
						vim.diagnostic.goto_prev()
					end,
					desc = "Previous diagnostic",
				},
				["]d"] = {
					function()
						vim.diagnostic.goto_next()
					end,
					desc = "Next diagnostic",
				},
				["gl"] = {
					function()
						vim.diagnostic.open_float()
					end,
					desc = "Hover diagnostics",
				},
			},
			v = {},
		}

		if capabilities.codeActionProvider then
			lsp_mappings.n["<leader>la"] = {
				function()
					vim.lsp.buf.code_action()
				end,
				desc = "LSP code action",
			}
			lsp_mappings.v["<leader>la"] = lsp_mappings.n["<leader>la"]
		end

		if capabilities.declarationProvider then
			lsp_mappings.n["gD"] = {
				function()
					vim.lsp.buf.declaration()
				end,
				desc = "Declaration of current symbol",
			}
		end

		if capabilities.definitionProvider then
			lsp_mappings.n["gd"] = {
				function()
					vim.lsp.buf.definition()
				end,
				desc = "Show the definition of current symbol",
			}
		end

		if capabilities.documentFormattingProvider then
			lsp_mappings.n["<leader>lf"] = {
				function()
					vim.lsp.buf.format(mlnvim.lsp.format_opts)
				end,
				desc = "Format code",
			}
			lsp_mappings.v["<leader>lf"] = lsp_mappings.n["<leader>lf"]

			vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
				vim.lsp.buf.format(mlnvim.lsp.format_opts)
			end, { desc = "Format file with LSP" })
			local autoformat = mlnvim.lsp.formatting.format_on_save
			local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
			if
				autoformat.enabled
				and (tbl_isempty(autoformat.allow_filetypes or {}) or tbl_contains(autoformat.allow_filetypes, filetype))
				and (
					tbl_isempty(autoformat.ignore_filetypes or {})
					or not tbl_contains(autoformat.ignore_filetypes, filetype)
				)
			then
				local autocmd_group = "auto_format_" .. bufnr
				vim.api.nvim_create_augroup(autocmd_group, { clear = true })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = autocmd_group,
					buffer = bufnr,
					desc = "Auto format buffer " .. bufnr .. " before save",
					callback = function()
						if vim.g.autoformat_enabled then
							vim.lsp.buf.format(mlnvim.default_tbl({ bufnr = bufnr }, mlnvim.lsp.format_opts))
						end
					end,
				})
				lsp_mappings.n["<leader>uf"] = {
					function()
						mlnvim.ui.toggle_autoformat()
					end,
					desc = "Toggle autoformatting",
				}
			end
		end

		if capabilities.documentHighlightProvider then
			local highlight_name = vim.fn.printf("lsp_document_highlight_%d", bufnr)
			vim.api.nvim_create_augroup(highlight_name, {})
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				group = highlight_name,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.document_highlight()
				end,
			})
			vim.api.nvim_create_autocmd("CursorMoved", {
				group = highlight_name,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.clear_references()
				end,
			})
		end

		if capabilities.hoverProvider then
			lsp_mappings.n["K"] = {
				function()
					vim.lsp.buf.hover()
				end,
				desc = "Hover symbol details",
			}
		end

		if capabilities.implementationProvider then
			lsp_mappings.n["gI"] = {
				function()
					vim.lsp.buf.implementation()
				end,
				desc = "Implementation of current symbol",
			}
		end

		if capabilities.referencesProvider then
			lsp_mappings.n["gr"] = {
				function()
					vim.lsp.buf.references()
				end,
				desc = "References of current symbol",
			}
		end

		if capabilities.renameProvider then
			lsp_mappings.n["<leader>lr"] = {
				function()
					vim.lsp.buf.rename()
				end,
				desc = "Rename current symbol",
			}
		end

		if capabilities.signatureHelpProvider then
			lsp_mappings.n["<leader>lh"] = {
				function()
					vim.lsp.buf.signature_help()
				end,
				desc = "Signature help",
			}
		end

		if capabilities.typeDefinitionProvider then
			lsp_mappings.n["gT"] = {
				function()
					vim.lsp.buf.type_definition()
				end,
				desc = "Definition of current type",
			}
		end

		mlnvim.set_mappings(user_plugin_opts("lsp.mappings", lsp_mappings), { buffer = bufnr })
		if not vim.tbl_isempty(lsp_mappings.v) then
			mlnvim.which_key_register({ v = { ["<leader>"] = { l = { name = "LSP" } } } }, { buffer = bufnr })
		end

		local on_attach_override = user_plugin_opts("lsp.on_attach", nil, false)
		local aerial_avail, aerial = pcall(require, "aerial")
		conditional_func(on_attach_override, true, client, bufnr)
		conditional_func(aerial.on_attach, aerial_avail, client, bufnr)
	end

--- The default mlnvim LSP capabilities
mlnvim.lsp.capabilities = vim.lsp.protocol.make_client_capabilities()
mlnvim.lsp.capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
mlnvim.lsp.capabilities.textDocument.completion.completionItem.snippetSupport = true
mlnvim.lsp.capabilities.textDocument.completion.completionItem.preselectSupport = true
mlnvim.lsp.capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
mlnvim.lsp.capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
mlnvim.lsp.capabilities.textDocument.completion.completionItem.deprecatedSupport = true
mlnvim.lsp.capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
mlnvim.lsp.capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
mlnvim.lsp.capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = { "documentation", "detail", "additionalTextEdits" },
}
mlnvim.lsp.capabilities = user_plugin_opts("lsp.capabilities", mlnvim.lsp.capabilities)
mlnvim.lsp.flags = user_plugin_opts("lsp.flags")

--- Get the server settings for a given language server to be provided to the server's `setup()` call
-- @param  server_name the name of the server
-- @return the table of LSP options used when setting up the given language server
function mlnvim.lsp.server_settings(server_name)
	local server = require("lspconfig")[server_name]
	local opts = user_plugin_opts( -- get user server-settings
		"lsp.server-settings." .. server_name,
		user_plugin_opts("server-settings." .. server_name, { -- get default server-settings
			capabilities = vim.tbl_deep_extend("force", mlnvim.lsp.capabilities, server.capabilities or {}),
			flags = vim.tbl_deep_extend("force", mlnvim.lsp.flags, server.flags or {}),
		}, true, "configs")
	)
	local old_on_attach = server.on_attach
	local user_on_attach = opts.on_attach
	opts.on_attach = function(client, bufnr)
		conditional_func(old_on_attach, true, client, bufnr)
		mlnvim.lsp.on_attach(client, bufnr)
		conditional_func(user_on_attach, true, client, bufnr)
	end
	return opts
end

return mlnvim.lsp
