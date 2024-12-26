local jobId = 0

vim.keymap.set('n', "<leader>st", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 15)
  vim.cmd("startinsert")
  jobId = vim.bo.channel
end)

vim.keymap.set({ "n", "v" }, "<leader>sc", function()
  if jobId == 0 then
    vim.notify("No active terminal", vim.log.levels.WARN)
    return
  end
  local cmd = vim.fn.input("Terminal Command: ")
  if cmd ~= "" then
    pcall(vim.fn.chansend, jobId, { cmd .. "\r\n" })
  else
    vim.notify("No command entered", vim.log.levels.WARN)
  end
end, { noremap = true, silent = true, desc = "Run CMD in terminal" })
