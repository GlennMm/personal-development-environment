return {
  {
    "tjdevries/present.nvim",
  },
  {
    "tpope/vim-dadbod",
    "kristijanhusak/vim-dadbod-completion",
    "kristijanhusak/vim-dadbod-ui",
  },
  {
    'laytan/cloak.nvim',
    event = "VeryLazy",
    keys = {
      { '<leader>uc', '<cmd>CloakToggle<CR>', desc = 'Hide Toggle Cloak' },
    },
    opts = {
      enabled = true,
      cloak_character = '*',
      highlight_group = 'Comment',
      cloak_length = nil,
      try_all_patterns = true,
      cloak_telescope = true,
      patterns = {
        {
          file_pattern = '.env*',
          cloak_pattern = '=.+',
          replace = nil,
        },
      },
    },
    config = true,
  },
  {
    "Fildo7525/pretty_hover",
    event = "LspAttach",
    opts = {}
  },
  {
    "windwp/nvim-autopairs",
    opts = {
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "vim" },
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
    end,
  }
}
