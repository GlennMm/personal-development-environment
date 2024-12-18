vim.api.nvim_create_autocmd('TextYankPost', {
	desc = "Highlisht when yanking text",
	group = vim.api.nvim_create_augroup('kickstart-highlight-text', { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local cli = vim.lsp.get_client_by_id(args.data.client_id)
		if not cli then return end
		if cli.supports_method('textDocument/formatting', { bufnr = 0 }) then
			vim.api.nvim_create_autocmd('BufWritePre', {
				buffer = args.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = args.buf, id = cli.id })
				end
			})
		end
	end
})
