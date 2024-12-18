return {
	"folke/which-key.nvim",
	lazy = false,
	opts = {},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.add {
			{ "<leader>a",  group = "Angular" },
			{ "<leader>A",  group = "Terminal" },
			{ "<leader>c",  group = "Trouble LSP" },
			{ "<leader>n",  group = "Nx" },
			{ "<leader>f",  group = "Telescope" },
			{ "<leader>l",  group = "Lsp" },
			{ "<leader>L",  group = "Lazy" },
			{ "<leader>d",  group = "Debug" },
			{ "<leader>g",  group = "Git" },
			{ "<leader>t",  group = "Test" },
			{ "<leader>s",  group = "Neovim Terminal" },
			{ "<leader>u",  group = "Utils" },
			{ "<leader>p",  group = "Projects" },
			{ "<leader>x",  group = "Trouble" },
			{ "<leader>r",  group = "Rest Client" },
			{ "<leader>",   group = "Run lua" },
			{ "<leader>T",  group = "Todo" },
			{ "<leader>Ll", function() vim.cmd([[Lazy]]) end,      desc = "Lazy" },
			{ "<leader>Ls", function() vim.cmd([[Lazy sync]]) end, desc = "Lazy Sync" },
			{ "<leader>w",  proxy = "<c-w>",                       group = "windows" }, -- proxy to window mappings
			{ "<leader>b", group = "buffers", expand = function()
				return require("which-key.extras").expand.buf()
			end
			},
			{ "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
			{ "<leader>w", "<cmd>w<cr>", desc = "Write" },
		}
	end
}
