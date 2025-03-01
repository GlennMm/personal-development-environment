return {
  "GlennMm/autosaver", -- Replace with your GitHub repo if different
  ---@class AutosaveOptions
  ---@field excluded_filetypes table<string, boolean> List of filetypes to exclude from autosave
  ---@field autosave_function? fun() Custom function to handle autosavin
  opts = {
    excluded_filetypes = { markdown = true, gitcommit = true },
  },
  config = true,
}
