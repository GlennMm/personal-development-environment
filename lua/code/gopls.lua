return {
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", 'gomod' },
		build = ':lua require("go.install").update_all_sync()'
	},
	{
		"olexsmir/gopher.nvim",
		ft = "go",
		-- branch = "develop", -- if you want develop branch
		-- keep in mind, it might break everything
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"mfussenegger/nvim-dap", -- (optional) only if you use `gopher.dap`
		},
		-- (optional) will update plugin's deps on every update
		build = function()
			vim.cmd.GoInstallDeps()
		end,
		---@type gopher.Config
		opts = {
			commands = {
				go = "go",
				gomodifytags = "gomodifytags",
				gotests = "gotests",
				impl = "impl",
				iferr = "iferr",
				dlv = "dlv",
			},
			gotests = {
				-- gotests doesn't have template named "default" so this plugin uses "default" to set the default template
				template = "default",
				-- path to a directory containing custom test code templates
				template_dir = nil,
				-- switch table tests from using slice to map (with test name for the key)
				-- works only with gotests installed from develop branch
				named = false,
			},
			gotag = {
				transform = "snakecase",
			},
		},
		config = function(opts)
			require("gopher").setup(opts)
			require("gopher.dap").setup()
		end,
	}
}
