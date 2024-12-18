return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require 'nvim-treesitter.configs'.setup {
				ensure_installed = {
					"c",
					"lua",
					"go",
					"angular",
					"bash",
					"c_sharp",
					"dart",
					"gomod",
					"gosum",
					"gotmpl",
					"gowork",
					"html",
					"css",
					"javascript",
					"prisma",
					"rust",
					"typescript",
					"vue",
					"zig",
				},
				sync_install = false,
				auto_install = true,
				ignore_install = { "javascript" },
				highlight = {
					enable = true,
					disable = function(_, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
					additional_vim_regex_highlighting = true,
				},
			}
		end
	}
}
