return {
  'nvim-neotest/neotest',
  event = "LspAttach",
  dependencies = {
    'sidlatau/neotest-dart',
    "rouge8/neotest-rust",
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-jest",
    "marilari88/neotest-vitest",
    "mrcjkb/rustaceanvim",
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-plenary",
    {
      "fredrikaverpil/neotest-golang", -- Installation
      dependencies = {
        "leoluz/nvim-dap-go",
      },
    },
    "lawrence-laz/neotest-zig",
    "nvim-neotest/neotest-vim-test"
  },
  cmds = {
    'Neotest run',
  },
  keys = {
    { "<leader>ta", function() require("neotest").run.attach() end,                                      desc = "[t]est [a]ttach" },
    { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,                       desc = "[t]est run [f]ile" },
    { "<leader>tA", function() require("neotest").run.run(vim.uv.cwd()) end,                             desc = "[t]est [A]ll files" },
    { "<leader>tS", function() require("neotest").run.run({ suite = true }) end,                         desc = "[t]est [S]uite" },
    { "<leader>tn", function() require("neotest").run.run() end,                                         desc = "[t]est [n]earest" },
    { "<leader>tl", function() require("neotest").run.run_last() end,                                    desc = "[t]est [l]ast" },
    { "<leader>ts", function() require("neotest").summary.toggle() end,                                  desc = "[t]est [s]ummary" },
    { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end,  desc = "[t]est [o]utput" },
    { "<leader>tO", function() require("neotest").output_panel.toggle() end,                             desc = "[t]est [O]utput panel" },
    { "<leader>tt", function() require("neotest").run.stop() end,                                        desc = "[t]est [t]erminate" },
    { "<leader>td", function() require("neotest").run.run({ suite = false, strategy = "dap" }) end,      desc = "Debug nearest test" },
    { "<leader>tD", function() require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" }) end, desc = "Debug current file" },
  },
  config = function()
    require('neotest').setup({
      adapters = {
        require("neotest-python")({
          dap = { justMyCode = false },
        }),
        require("neotest-plenary"),
        require("neotest-vim-test")({
          ignore_file_types = { "vim", "lua" },
        }),
        require('neotest-dart') {
          command = 'flutter',
          --[[ command = 'dart', ]]
          use_lsp = true,
          custom_test_method_names = {},
        },
        require('neotest-jest')({
          jestCommand = "npm test --",
          jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        }),
        require("neotest-vitest"),
        require('rustaceanvim.neotest'),
        require("neotest-golang")
      },
      config = {
        output_panel = { open_on_run = true },
        diagnostic = true
      }
    });
  end
}
