local M = {}
local map = vim.keymap.set
-- local navic = require("nvim-navic")


-- export on_attach & capabilities
M.on_attach = function(client, bufnr)
	local function opts(desc)
		return { buffer = bufnr, desc = "LSP " .. desc }
	end

	map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
	map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
	map("n", "K", vim.lsp.buf.hover, opts "hover information")
	map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
	map("n", "<leader>lH", vim.lsp.buf.signature_help, opts "Show signature help")
	map("n", "<leader>ld", vim.lsp.buf.type_definition, opts "Go to type definition")
	map("n", "gr", vim.lsp.buf.references, opts "Show references")

	vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx)
		require("ts-error-translator").translate_diagnostics(err, result, ctx)
		vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
	end

	-- navic.attach(client, bufnr)
end

-- disable semanticTokens
M.on_init = function(client, _)
	if client.supports_method "textDocument/semanticTokens" then
		client.server_capabilities.semanticTokensProvider = nil
	end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}
M.capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true
}
M.defaults = function()
	require("lspconfig").lua_ls.setup {
		on_attach = M.on_attach,
		capabilities = M.capabilities,
		on_init = M.on_init,

		settings = {
			Lua = {
				format = {
					enable = true,
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						[vim.fn.expand "$VIMRUNTIME/lua"] = true,
						[vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
						[vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
						[vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
					},
					maxPreload = 100000,
					preloadFileSize = 10000,
				},
				runtime = {
					version = 'LuaJIT',
					special = {
						spec = 'require',
					},
				},
				hint = {
					enable = true,
					arrayIndex = 'Disable', -- "Enable" | "Auto" | "Disable"
					await = true,
					paramName = 'Literal',  -- "All" | "Literal" | "Disable"
					paramType = true,
					semicolon = 'Disable',  -- "All" | "SameLine" | "Disable"
					setType = false,
				},
				telemetry = {
					enable = false,
				}
			},
		},
	}
end

return M
