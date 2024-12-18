local lsp_utils = require "config.lsp.utils"

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
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
      "SmiteshP/nvim-navic"
    },
    config = function()
      local lspconfig = require "lspconfig"
      require("mason").setup()
      require("mason-lspconfig").setup()


      require("lspconfig").lua_ls.setup {
        on_attach = lsp_utils.on_attach,
        capabilities = lsp_utils.capabilities,
        on_init = lsp_utils.on_init,
        settings = {
          Lua = {
            format = {
              enable = true,
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
                [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
              },
              maxPreload = 100000,
              preloadFileSize = 10000,
            },
            runtime = {
              version = 'LuaJIT',
              special = {
                spec = 'require',
              },
            },
            hint = {
              enable = true,
              arrayIndex = 'Disable', -- "Enable" | "Auto" | "Disable"
              await = true,
              paramName = 'Literal',  -- "All" | "Literal" | "Disable"
              paramType = true,
              semicolon = 'Disable',  -- "All" | "SameLine" | "Disable"
              setType = false,
            },
            telemetry = {
              enable = false,
            }
          },
        },
      }
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

          local lsp_cfg = require('config.lsp.utils')
          local opt = {
            on_attach = lsp_cfg.on_attach,
            capabilities = lsp_cfg.capabilities,
            on_init = lsp_cfg.on_init,
          }
          local require_ok, settings = pcall(require, "config.lsp.utils.settings." .. server)
          if require_ok then
            opt = vim.tbl_deep_extend("force", settings, opt)
          end

          lspconfig[server].setup(opt)
        end,
      })

      --[[ vim.g.mason_binaries_list = opts.ensure_installed ]]
    end
  }
}
