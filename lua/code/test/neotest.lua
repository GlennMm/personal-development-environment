--[[ return {
  {
    "klen/nvim-test",
    event = "LspAttach",
    config = function()
      require('nvim-test.runners.jest'):setup {
        command = "./node_modules/.bin/vitest",                                   -- a command to run the test runner

        file_pattern = "\\v(__tests__/.*|(spec|test))\\.(js|jsx|coffee|ts|tsx)$", -- determine whether a file is a testfile
        find_files = { "{name}.test.{ext}", "{name}.spec.{ext}" },                -- find testfile for a file

        filename_modifier = nil,                                                  -- modify filename before tests run (:h filename-modifiers)
        working_directory = nil,                                                  -- set working directory (cwd by default)
      }
      require('nvim-test').setup {
        run = true,               -- run tests (using for debug)
        commands_create = true,   -- create commands (TestFile, TestLast, ...)
        filename_modifier = ":.", -- modify filenames before tests run(:h filename-modifiers)
        silent = false,           -- less notifications
        term = "terminal",        -- a terminal to run ("terminal"|"toggleterm")
        termOpts = {
          direction = "vertical", -- terminal's direction ("horizontal"|"vertical"|"float")
          width = 96,             -- terminal's width (for vertical|float)
          height = 24,            -- terminal's height (for horizontal|float)
          go_back = false,        -- return focus to original window after executing
          stopinsert = "auto",    -- exit from insert mode (true|false|"auto")
          keep_one = true,        -- keep only one terminal for testing
        },
        runners = {               -- setup tests runners
          cs = "nvim-test.runners.dotnet",
          go = "nvim-test.runners.go-test",
          haskell = "nvim-test.runners.hspec",
          javascriptreact = "nvim-test.runners.jest",
          javascript = "nvim-test.runners.jest",
          lua = "nvim-test.runners.busted",
          python = "nvim-test.runners.pytest",
          ruby = "nvim-test.runners.rspec",
          rust = "nvim-test.runners.cargo-test",
          typescript = "nvim-test.runners.jest",
          typescriptreact = "nvim-test.runners.jest",
        }
      }
    end
  }

} ]]

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
    "lawrence-laz/neotest-zig",
    "nvim-neotest/neotest-vim-test",
    "nvim-neotest/neotest-go",
    "Issafalcon/neotest-dotnet",
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
    local neotest_ns = vim.api.nvim_create_namespace("neotest")
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message =
              diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
          return message
        end,
      },
    }, neotest_ns)
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
        require("neotest-go"),
        require("neotest-dotnet")
      },
      config = {
        output_panel = { open_on_run = true },
        diagnostic = true
      }
    });
  end
}
