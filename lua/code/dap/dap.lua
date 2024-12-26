return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    'rcarriga/nvim-dap-ui',
    "nvim-telescope/telescope-dap.nvim",
    "nvim-neotest/nvim-nio",
    "williamboman/mason.nvim",
    "leoluz/nvim-dap-go",
    'theHamsta/nvim-dap-virtual-text',
    "mfussenegger/nvim-dap-python",
  },
  keys = {
    { "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>",      desc = "Toggle Breakpoint" },
    { "<leader>db", "<cmd>lua require'dap'.step_back()<cr>",              desc = "Step Back" },
    { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>",               desc = "Continue" },
    { "<leader>dC", "<cmd>lua require'dap'.run_to_cursor()<cr>",          desc = "Run To Cursor" },
    { "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>",             desc = "Disconnect" },
    { "<leader>dg", "<cmd>lua require'dap'.session()<cr>",                desc = "Get Session" },
    { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>",              desc = "Step Into" },
    { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>",              desc = "Step Over" },
    { "<leader>du", "<cmd>lua require'dap'.step_out()<cr>",               desc = "Step Out" },
    { "<leader>dp", "<cmd>lua require'dap'.pause()<cr>",                  desc = "Pause" },
    { "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>",            desc = "Toggle Repl" },
    { "<leader>dq", "<cmd>lua require'dap'.close()<cr>",                  desc = "Quit" },
    { "<leader>dU", "<cmd>lua require'dapui'.toggle({reset = true})<cr>", desc = "Toggle UI" },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    require("mason-nvim-dap").setup {
      ensured_installed = {
        "delve",
        "codelldb",
        "cpptools",
        "debugpy",
        "go-debug-adapter",
        "js-debug-adapter",
        "dart-debug-adapter",
      },
      automatic_install = true,
      handlers = {}
    }
    vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
    vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })

    dapui.setup {
      icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
      controls = {
        icons = {
          pause = "",
          play = "▶",
          step_into = "",
          step_over = "",
          step_out = "",
          step_back = "b",
          run_last = "▶▶",
          terminate = "",
          disconnect = "⏏",
        },
      },
    }
    require("nvim-dap-virtual-text").setup {}
    vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })

    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close

    require("dap-go").setup()
    require("dap-python").setup "~/.virtualenvs/debugpy/bin/python"
    dap.adapters.dart = {
      type = "executable",
      command = "dart",
      args = { "debug_adapter" },
    }
    dap.configurations.dart = {
      {
        type = "dart",
        request = "launch",
        name = "Launch Flutter Program",
        program = "${file}",
        cwd = "${workspaceFolder}",
        toolArgs = { "-d", "linux" },
      },
    }


    dap.adapters.coreclr = {
      type = 'executable',
      command = '/usr/local/bin/netcoredbg/netcoredbg',
      args = { '--interpreter=vscode' }
    }

    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
          return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
      },
    }
    require("telescope").load_extension "dap"
    -- ui modifications
    vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
    vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
    vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })
    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "red", linehl = "", numhl = "" })
    vim.fn.sign_define(
      "DapBreakpointCondition",
      { text = " ", texthl = "red", linehl = "", numhl = "" }
    )
    vim.fn.sign_define(
      "DapBreakpointRejected",
      { text = "", texthl = "red", linehl = "", numhl = "" }
    )
    vim.fn.sign_define("DapLogPoint", { text = ".>", texthl = "red", linehl = "", numhl = "" })
  end,
}
