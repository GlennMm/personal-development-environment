--[[ vim.api.nvim_create_user_command('Wa', function()
  vim.cmd('wall')
end, {})

vim.api.nvim_create_user_command('Wqa', function()
  vim.cmd('wqall')
end, {})

vim.api.nvim_create_user_command('Q', function()
  vim.cmd('quit')
end, {})

vim.api.nvim_create_user_command('Qa', function()
  vim.cmd('qall')
end, {}) ]]
