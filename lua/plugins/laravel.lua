return {
  "adalessa/laravel.nvim",
  dependencies = {
    "tpope/vim-dotenv",
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
    "kevinhwang91/promise-async",
  },
  cmd = { "Laravel" },
  keys = {
    { "<leader>pa", ":Laravel artisan<cr>" },
    { "<leader>pr", ":Laravel routes<cr>" },
    { "<leader>pm", ":Laravel related<cr>" },
  },
  event = { "VeryLazy" },
  opts = {},
  config = true,
}

