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
          vim.keymap.set({ "n" }, "<LEADER>ns", require("package-info").show, { silent = true, noremap = true })

          -- Hide dependency versions
          vim.keymap.set({ "n" }, "<LEADER>nc", require("package-info").hide, { silent = true, noremap = true })

          -- Toggle dependency versions
          vim.keymap.set({ "n" }, "<LEADER>nt", require("package-info").toggle, { silent = true, noremap = true })

          -- Update dependency on the line
          vim.keymap.set({ "n" }, "<LEADER>nu", require("package-info").update, { silent = true, noremap = true })

          -- Delete dependency on the line
          vim.keymap.set({ "n" }, "<LEADER>nd", require("package-info").delete, { silent = true, noremap = true })

          -- Install a new dependency
          vim.keymap.set({ "n" }, "<LEADER>ni", require("package-info").install, { silent = true, noremap = true })

          -- Install a different dependency version
          vim.keymap.set({ "n" }, "<LEADER>np", require("package-info").change_version, { silent = true, noremap = true })

          require("telescope").load_extension("package_info")
        end
      },
      {
        "b0o/schemastore.nvim",
      }
    },
    config = function()
      local lspconfig = require "lspconfig"
      require("mason").setup()
      require("mason-lspconfig").setup()

      local lsp_utils = require "config.lsp.utils"
      local capabilities = require('blink.cmp').get_lsp_capabilities(lsp_utils.capabilities)

      -- lsp config cfg
      require("lspconfig").lua_ls.setup {
        on_attach = lsp_utils.on_attach,
        capabilities = capabilities,
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

      -- navic cfg
      lsp_utils.navic_setup()
    end
  }
}
