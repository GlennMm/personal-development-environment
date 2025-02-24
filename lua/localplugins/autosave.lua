return {
  dir = vim.fn.stdpath("config") .. "/lua/dev/autosaver",
  config = function()
    require("autosaver").setup({
      enabled = false,
      excluded_filetypes = { markdown = true, gitcommit = true, text = true },
    })
  end,
}
