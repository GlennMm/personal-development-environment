return {
  ['rust-analyzer'] = {
    imports = {
      granularity = {
        group = 'module',
      },
      prefix = 'self',
    },
    cargo = {
      buildScripts = {
        enable = true,
      },
    },
    procMacro = {
      enable = true,
    },
    inlayHints = {
      bindingModeHints = { enable = true },
      closureCaptureHints = { enable = true },
      closureReturnTypeHints = { enable = true },
      lifetimeElisionHints = { enable = true },
      reborrowHints = { enable = true },
    },
    checkOnSave = {
      command = 'clippy',
    },
  },
}
