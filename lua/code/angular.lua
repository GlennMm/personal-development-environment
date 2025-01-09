return {
  'joeveiga/ng.nvim',
  event = 'VeryLazy',
  config = function()
    local ng = require("ng");
    vim.keymap.set("n", "<leader>at", ng.goto_template_for_component,
      { noremap = true, silent = true, desc = "Angular go to template for component" })
    vim.keymap.set("n", "<leader>ac", ng.goto_component_with_template_file,
      { noremap = true, silent = true, desc = "Angular go to component for template." })
    vim.keymap.set("n", "<leader>aT", ng.get_template_tcb,
      { noremap = true, silent = true, desc = "Angular get template tcb" })
  end
}
