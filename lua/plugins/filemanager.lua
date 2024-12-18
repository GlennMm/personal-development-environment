return {
	'stevearc/oil.nvim',
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		delete_to_trash = true,
		lsp_file_methods = {
			enabled = true,
			timeout_ms = 500,
			autosave_changes = true
		},
		float = {
			padding = 2,
			max_width = 0,
			max_height = 0,
			border = "rounded",
			win_options = {
				winblend = 0,
			},
			get_win_title = nil,
			preview_split = "right",
			override = function(conf)
				return conf
			end,
		},
		preview_win = {
			update_on_cursor_moved = true,
			preview_method = "fast_scratch",
			disable_preview = function(filename)
				return false
			end,
			win_options = {},
		},
	},
	dependencies = {
		{ 'echasnovski/mini.icons', opts = {} }
	},
	config = function(_, opts)
		require('oil').setup(opts)

		vim.keymap.set('n', '-', '<CMD>Oil --float<CR>', { desc = 'Open parent directory' })
		vim.keymap.set('n', '<leader>e', '<CMD>Oil --float<CR>', { desc = 'Open parent directory' })
	end
}
