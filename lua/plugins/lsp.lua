return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      {
        'SmiteshP/nvim-navic',
        opts = {
          highlight = true,
          lsp = {
            auto_attach = true,
            safe_output = true,
          },
          click = true
        }
      },
      {
        'dmmulroy/ts-error-translator.nvim',
        event = "VeryLazy",
        config = function()
          require("ts-error-translator").setup()
        end
      },
      {
        'rachartier/tiny-inline-diagnostic.nvim',
        event = "VeryLazy",
        config = function()
          require('tiny-inline-diagnostic').setup()
        end
      },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      'saghen/blink.cmp',
      {
        "vuki656/package-info.nvim",
        dependencies = {
          "MunifTanjim/nui.nvim",
          "nvim-telescope/telescope.nvim",
        },
        config = function()
          require('package-info').setup()
          -- Show dependency versions
          vim.keymap.set({ "n" }, "<leader>ns", require("package-info").show, { silent = true, noremap = true })

          -- Hide dependency versions
          vim.keymap.set({ "n" }, "<leader>nc", require("package-info").hide, { silent = true, noremap = true })

          -- Toggle dependency versions
          vim.keymap.set({ "n" }, "<leader>nt", require("package-info").toggle, { silent = true, noremap = true })

          -- Update dependency on the line
          vim.keymap.set({ "n" }, "<leader>nu", require("package-info").update, { silent = true, noremap = true })

          -- Delete dependency on the line
          vim.keymap.set({ "n" }, "<leader>nd", require("package-info").delete, { silent = true, noremap = true })

          -- install a new dependency
          vim.keymap.set({ "n" }, "<leader>ni", require("package-info").install, { silent = true, noremap = true })

          -- install a different dependency version
          vim.keymap.set({ "n" }, "<leader>np", require("package-info").change_version, { silent = true, noremap = true })

          require("telescope").load_extension("package_info")
        end
      },
      {
        "b0o/schemastore.nvim",
      },
      {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
          {
            "<leader>xx",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
          },
          {
            "<leader>xX",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer Diagnostics (Trouble)",
          },
          {
            "<leader>cs",
            "<cmd>Trouble symbols toggle focus=false<cr>",
            desc = "Symbols (Trouble)",
          },
          {
            "<leader>cl",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
          },
          {
            "<leader>xL",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location List (Trouble)",
          },
          {
            "<leader>xQ",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
          },
        },
      }
    },
    config = function()
      local lspconfig = require "lspconfig"
      require("mason").setup()
      require("mason-lspconfig").setup()

      local lsp_utils = require "config.lsp.utils"

      lsp_utils.defaults()

      -- mason lsp cfg
      require('mason-lspconfig').setup_handlers({
        function(server)
          if server == "tsserver" then
            return
          end

          if server == "rust_analyzer" then
            return
          end

          if server == "vtsls" then
            return
          end

          if server == "lua_ls" then
            return
          end

          local lsp_cfg = require('config.lsp.utils')
          local opts = {
            on_attach = lsp_cfg.on_attach,
            capabilities = lsp_cfg.capabilities,
            on_init = lsp_cfg.on_init,
          }
          local require_ok, settings = pcall(require, "config.lsp.settings." .. server)
          if require_ok then
            opts = vim.tbl_deep_extend("force", settings, opts)
          end

          lspconfig[server].setup(opts)
        end,
      })

      -- navic cfg
      lsp_utils.navic_setup()
    end
  }
}
