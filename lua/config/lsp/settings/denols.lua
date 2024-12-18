return {
  cmd = { "deno", "lsp" },
  filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
  root_dir = require("lspconfig.util").root_pattern("deno.json", "tsconfig.json", ".git"),
  init_options = {
    lint = true,
    unstable = true,
    suggest = {
      imports = {
        hosts = {
          ["https://deno.land"] = true,
          ["https://cdn.nest.land"] = true,
          ["https://crux.land"] = true,
        },
      },
    },
  },
  settings = {
    deno = {
      enable = true,
      lint = true,
      unstable = false,
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = {
          enabled = "all",
          suppressWhenArgumentMatchesName = true,
        },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = {
          enabled = true,
          suppressWhenTypeMatchesName = true,
        },
      },
    },
  },
}
