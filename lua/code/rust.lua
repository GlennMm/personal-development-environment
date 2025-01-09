return {
  'mrcjkb/rustaceanvim',
  lazy = false,
  config = function()
    ---@type rustaceanvim.Opts
    vim.g.rustaceanvim = {
      -- Plugin configuration
      ---@type rustaceanvim.tools.Opts
      tools = {
      },
      ---@type rustaceanvim.dap.Opts
      dap = {
        -- ...
      },
      -- LSP configuration
      ---@type rustaceanvim.lsp.ClientOpts
      server = {
        on_attach = function(client, bufnr)
          local map = vim.keymap.set
          local navic = require("nvim-navic")


          -- you can also put keymaps in here
          local function opts(desc)
            return { buffer = bufnr, desc = "LSP " .. desc }
          end

          map("n", "K", vim.cmd.RustLsp { "hover", 'actions' }, opts "hover information")
          map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
          map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
          map("n", "gR", vim.lsp.buf.references, opts "Show references")
          map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
          map("n", "<leader>lh", vim.lsp.buf.signature_help, opts "Show signature help")
          map("n", "<leader>ld", vim.lsp.buf.type_definition, opts "Go to type definition")
          map("n", "<leader>lr", vim.lsp.buf.rename, opts "Rename")
          map("n", "<leader>lc", vim.cmd.RustLsp { "hover", 'actions' }, opts "Code action")
          map("n", "<leader>la", vim.lsp.codelens.run, opts "Run code action")
          map("n", "<leader>lf", vim.lsp.buf.format, opts "Format")
          map("n", "<leader>lR", vim.lsp.buf.references, opts "Show references")

          vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx)
            require("ts-error-translator").translate_diagnostics(err, result, ctx)
            vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
          end

          local signs = { ERROR = " ", WARN = " ", INFO = " ", HINT = " " }
          vim.diagnostic.config({
            signs = {
              text = signs
            },
            virtual_text = false
          })

          for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
          end


          --[[
  vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]
          -- ]]
          if client.server_capabilities.documentSymbolProvider then
            navic.attach(client, bufnr)
          end
        end,
        default_settings = require("config.lsp.settings.rust_analyzer"),
      },
    }
  end
}
