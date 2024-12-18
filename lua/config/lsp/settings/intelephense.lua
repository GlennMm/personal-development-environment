return {
  cmd = { 'intelephense', '--stdio' },
  filetypes = { 'php' },
  root_pattern = { 'composer.json', '.git' },
  settings = {
    intelephense = {
      files = {
        maxSize = 1000000,
      },
    },
  },
}
