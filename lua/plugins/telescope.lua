return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release; cmake --build build --config Release' },
    'andrew-george/telescope-themes',

  },
  config = function()
    vim.keymap.set("n", "<leader>fh", require('telescope.builtin').help_tags)
    vim.keymap.set("n", "<leader>fd", require('telescope.builtin').find_files)
    vim.keymap.set("n", "<leader>fg", require('telescope.builtin').live_grep)
    vim.keymap.set("n", "<leader>en", function()
      require('telescope.builtin').find_files {
        cwd = vim.fn.stdpath("config")
      }
    end)
    vim.keymap.set("n", "<leader>ft", ":Telescope themes<CR>", { noremap = true, silent = true, desc = "Theme Switcher" })
    vim.api.nvim_set_keymap('n', '<leader>qf', ':Telescope quickfix<CR>', { noremap = true, silent = true })
    local telescope = require('telescope')
    telescope.load_extension('themes')
  end
}
