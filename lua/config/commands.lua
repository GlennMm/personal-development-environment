-- re-mapping common typo.
vim.api.nvim_create_user_command("Wa", ":wa", {})
vim.api.nvim_create_user_command("W", ":w", {})
vim.api.nvim_create_user_command("Wqa", function()
  local count = 3 -- Countdown start

  local function update_notification()
    if count > 0 then
      vim.notify("Exiting Neovim in " .. count .. " second(s)...", vim.log.levels.INFO, {
        title = "Neovim",
        timeout = 1000, -- 1 second timeout
      })
      count = count - 1
      vim.defer_fn(update_notification, 1000) -- Schedule the next update
    else
      vim.cmd("wqa") -- Exit after countdown finishes
    end
  end

  update_notification()
end, {})
