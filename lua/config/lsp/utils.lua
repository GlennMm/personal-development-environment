local M = {}
local map = vim.keymap.set
local navic = require("nvim-navic")


-- export on_attach & capabilities
M.on_attach = function(client, bufnr)
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
  map("n", "<leader>la", vim.lsp.buf.code_action, opts "Code action")
  map("n", "<leader>lf", vim.lsp.buf.format, opts "Format")
  map("n", "<leader>lR", vim.lsp.buf.references, opts "Show references")
  map("n", "gR", vim.lsp.buf.references, opts "Show references")

  vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx)
    require("ts-error-translator").translate_diagnostics(err, result, ctx)
    vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
  end
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

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
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
M.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}
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

  local colors = {
    purple = "#C586C0",
    blue = "#569CD6",
    yellow = "#DCDCAA",
    green = "#4EC9B0",
    orange = "#CE9178",
    red = "#F44747",
    gray = "#808080",
  }
  -- Define highlights for navic
  vim.api.nvim_set_hl(0, "NavicIconsFile", { default = true, fg = colors.gray })
  vim.api.nvim_set_hl(0, "NavicIconsModule", { default = true, fg = colors.blue })
  vim.api.nvim_set_hl(0, "NavicIconsNamespace", { default = true, fg = colors.blue })
  vim.api.nvim_set_hl(0, "NavicIconsPackage", { default = true, fg = colors.orange })
  vim.api.nvim_set_hl(0, "NavicIconsClass", { default = true, fg = colors.yellow })
  vim.api.nvim_set_hl(0, "NavicIconsMethod", { default = true, fg = colors.purple })
  vim.api.nvim_set_hl(0, "NavicIconsProperty", { default = true, fg = colors.blue })
  vim.api.nvim_set_hl(0, "NavicIconsField", { default = true, fg = colors.blue })
  vim.api.nvim_set_hl(0, "NavicIconsConstructor", { default = true, fg = colors.green })
  vim.api.nvim_set_hl(0, "NavicIconsEnum", { default = true, fg = colors.green })
  vim.api.nvim_set_hl(0, "NavicIconsInterface", { default = true, fg = colors.green })
  vim.api.nvim_set_hl(0, "NavicIconsFunction", { default = true, fg = colors.purple })
  vim.api.nvim_set_hl(0, "NavicIconsVariable", { default = true, fg = colors.blue })
  vim.api.nvim_set_hl(0, "NavicIconsConstant", { default = true, fg = colors.orange })
  vim.api.nvim_set_hl(0, "NavicIconsString", { default = true, fg = colors.orange })
  vim.api.nvim_set_hl(0, "NavicIconsNumber", { default = true, fg = colors.orange })
  vim.api.nvim_set_hl(0, "NavicIconsBoolean", { default = true, fg = colors.orange })
  vim.api.nvim_set_hl(0, "NavicIconsArray", { default = true, fg = colors.orange })
  vim.api.nvim_set_hl(0, "NavicIconsObject", { default = true, fg = colors.orange })
  vim.api.nvim_set_hl(0, "NavicIconsKey", { default = true, fg = colors.purple })
  vim.api.nvim_set_hl(0, "NavicIconsNull", { default = true, fg = colors.red })
  vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { default = true, fg = colors.green })
  vim.api.nvim_set_hl(0, "NavicIconsStruct", { default = true, fg = colors.yellow })
  vim.api.nvim_set_hl(0, "NavicIconsEvent", { default = true, fg = colors.yellow })
  vim.api.nvim_set_hl(0, "NavicIconsOperator", { default = true, fg = colors.gray })
  vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { default = true, fg = colors.green })
  vim.api.nvim_set_hl(0, "NavicText", { default = true, fg = colors.gray })
  vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, fg = colors.gray })
end

return M
