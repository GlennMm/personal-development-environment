return {
	"folke/todo-comments.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		keywords = {
			FIX = {
				icon = " ", -- icon used for the sign, and in search results
				color = "error", -- can be a hex color, or a named color (see below)
				alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
				-- signs = false, -- configure signs for some keywords individually
			},
			TODO = { icon = " ", color = "info" },
			HACK = { icon = " ", color = "warning" },
			WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
			PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
			NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
			TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
		}
	},
	keys = {
		{ "<leader>Tn", "<cmd>lua require('todo-comments').jump_next()<cr>",                                                    desc = "Next todo comment" },
		{ "<leader>Tp", "<cmd>lua require('todo-comments').jump_prev()<cr>",                                                    desc = "Previous todo comment" },
		{ "<leader>Tt", "<cmd>lua require('todo-comments').jump_next({ keywords = { 'ERROR', 'WARNING', 'FIX', 'BUG' } })<cr>", desc = "Attention required comment" },
	},
	config = function(_, opts)
		local todo_comments = require("todo-comments")
		todo_comments.setup(opts)
		vim.keymap.set("n", "]t", function()
			todo_comments.jump_next()
		end, { desc = "Next todo comment" })

		vim.keymap.set("n", "[t", function()
			todo_comments.jump_prev()
		end, { desc = "Previous todo comment" })

		vim.keymap.set("n", "]t", function()
			todo_comments.jump_next({ keywords = { "ERROR", "WARNING" } })
		end, { desc = "Next error/warning todo comment" })
	end
}
