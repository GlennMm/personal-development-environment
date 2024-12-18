return {
  settings = {
    gopls = {
      gofumpt = true,
      usePlaceholders = false,
      semanticTokens = false,
      codelenses = {
        generate = true,   -- Don't show the `go generate` lens.
        gc_details = true, -- Show a code lens toggling the display of gc's choices.
      },
      analyses = {
        unreachable = true,    -- Disable the unreachable analyzer.
        unusedvariable = true, -- Enable the unusedvariable analyzer.
      },
      hoverKind = "FullDocumentation",
      ["ui.inlayHint.hints"] = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
}
