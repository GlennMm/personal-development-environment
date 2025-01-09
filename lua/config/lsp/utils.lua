local M = {}
local map = vim.keymap.set
local navic = require("nvim-navic")

-- export on_attach & capabilities
M.on_attach = function(client, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "K", vim.lsp.buf.hover, opts "hover information")
  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "gR", vim.lsp.buf.references, opts "Show references")
  map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
  map("n", "<leader>lh", vim.lsp.buf.signature_help, opts "Show signature help")
  map("n", "<leader>ld", vim.lsp.buf.type_definition, opts "Go to type definition")
  map("n", "<leader>lr", vim.lsp.buf.rename, opts "Rename")
  map("n", "<leader>lc", vim.lsp.buf.code_action, opts "Code action")
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
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "K", vim.lsp.buf.hover, opts "hover information")
  map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
  map("n", "<leader>lH", vim.lsp.buf.signature_help, opts "Show signature help")
  map("n", "<leader>ld", vim.lsp.buf.type_definition, opts "Go to type definition")
  map("n", "<leader>lr", vim.lsp.buf.rename, opts "Rename")
  map("n", "<leader>lc", vim.lsp.buf.code_action, opts "Code action")
  map("n", "<leader>la", vim.lsp.codelens.run, opts "Run code action")
  map("n", "<leader>lf", vim.lsp.buf.format, opts "Format")
  map("n", "<leader>lR", vim.lsp.buf.references, opts "Show references")
  map("n", "gR", vim.lsp.buf.references, opts "Show references")

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
end

-- disable semanticTokens
M.on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.caps = vim.lsp.protocol.make_client_capabilities()

M.caps.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}
M.caps.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

M.capabilities = require('blink.cmp').get_lsp_capabilities(M.caps)

M.defaults = function()
  require("lspconfig").lua_ls.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    on_init = M.on_init,

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
end

M.navic_setup = function()
  -- List of filetypes to exclude from showing the winbar
  local winbar_filetype_exclude = {
    "help",
    "startify",
    "dashboard",
    "packer",
    "neogitstatus",
    "NvimTree",
    "Trouble",
    "alpha",
    "lir",
    "Outline",
    "spectre_panel",
    "toggleterm",
    "oil"
  }

  -- Function to get navic location
  local function get_location()
    local status_ok, navic_location = pcall(navic.get_location, {})
    if not status_ok then
      return ""
    end

    if not navic.is_available() or navic_location == "error" then
      return ""
    end

    return navic_location
  end

  -- Function to check if the buffer should show winbar
  local function should_show_winbar()
    if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
      return false
    end
    return true
  end

  -- Setup winbar
  vim.api.nvim_create_autocmd({ "CursorMoved", "BufWinEnter", "BufFilePost" }, {
    callback = function()
      if should_show_winbar() then
        local location = get_location()
        if location ~= "" then
          vim.opt_local.winbar = "  " .. location
        end
      end
    end,
  })
end

return M
