local M = {}

M.setup = function()
	vim.api.nvim_create_autocmd('TermOpen', {
		group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
		callback = function()
			vim.opt.number = false
			vim.opt.relativenumber = false
		end
	})

	local job_id = 0
	vim.keymap.set('n', "<leader>st", function()
		vim.cmd.vnew()
		vim.cmd.term()
		vim.cmd.wincmd("J")
		vim.api.nvim_win_set_height(0, 15)
		vim.cmd("startinsert")
		job_id = vim.bo.channel
	end)

	vim.keymap.set({ "n", "v" }, "<leader>sc", function()
		if job_id == 0 then
			vim.notify("No active terminal", vim.log.levels.WARN)
			return
		end
		local cmd = vim.fn.input("Terminal Command: ")
		if cmd ~= "" then
			local ok, job_id = pcall(vim.b, "terminal_job_id")
			print(job_id)
			if ok and job_id then
				pcall(vim.fn.chansend, job_id, { cmd .. "\r\n" })
			else
				print("Error: Unable to get terminal job ID")
			end
		else
			vim.notify("No command entered", vim.log.levels.WARN)
		end
	end, { noremap = true, silent = true, desc = "Run CMD in terminal" })
end

return M
