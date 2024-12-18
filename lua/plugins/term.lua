return {
  "numToStr/FTerm.nvim",
  event = "VeryLazy",
  config = function()
    local fterm = require("FTerm")
    fterm.setup({
      dimensions = {
        height = 0.8,
        width = 0.8,
      },
      border = "single",
    })
  end,
  keys = {
    { "<leader>At", "<cmd>lua require('FTerm').toggle()<CR>", desc = "Floating Term" },
    {
      "<leader>Ag",
      function()
        local gitui = require("FTerm"):new({ cmd = "lazygit", border = "single", dimensions = { height = 0.8, width = 0.8 } })
        gitui:toggle()
      end,
      desc = "Lazy Git"
    },
    {
      "<leader>Ab",
      function()
        local btop = require("FTerm"):new({ cmd = "btop", border = "single", dimensions = { height = 0.8, width = 0.8 } })
        btop:toggle()
      end,
      desc = "BTop"
    },
    {
      "<leader>Ad",
      function()
        local btop = require("FTerm"):new({ cmd = "lazydocker", border = "single", dimensions = { height = 0.8, width = 0.8 } })
        btop:toggle()
      end,
      desc = "Lazy Docker"
    }
  }
}
