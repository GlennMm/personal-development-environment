local lspconfig = require "lspconfig"

return {
  root_dir = function(filename, bufnr)
    local denoRootDir = lspconfig.util.root_pattern("deno.json", "deno.json")(filename)
    if denoRootDir then
      -- print('this seems to be a deno project; returning nil so that tsserver does not attach');
      return nil
      -- else
      -- print('this seems to be a ts project; return root dir based on package.json')
    end

    return lspconfig.util.root_pattern "package.json"(filename)
  end,
  settings = {
    completions = {
      completeFunctionCalls = true,
    },
    typescript = {
      -- formating
      format = {
        indentStyle = "Smart",
        placeOpenBraceOnNewLineForControlBlocks = false,
        placeOpenBraceOnNewLineForFunctions = false,
        semicolons = "remove",
        tabSize = 2,
        trimTrailingWhitespace = true,
      },
      -- Inlay Hints preferences
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        parameterNames = true,
        parameterTypes = true,
        variableTypes = true,
        propertyDeclarationTypes = true,
        functionLikeReturnTypes = true,
        enumMemberValues = true,
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
      },
      -- Code Lens preferences
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
        showOnAllFunctions = true,
      },
      javascript = {
        -- formating
        format = {
          indentStyle = "Smart",
          placeOpenBraceOnNewLineForControlBlocks = false,
          placeOpenBraceOnNewLineForFunctions = false,
          semicolons = "remove",
          tabSize = 2,
          trimTrailingWhitespace = true,
        },
        -- Inlay Hints preferences
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        },
        -- Code Lens preferences
        implementationsCodeLens = {
          enabled = true,
        },
        referencesCodeLens = {
          enabled = true,
          showOnAllFunctions = true,
        },
      },
    },
  },
}
