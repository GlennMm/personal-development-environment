local ok, schemastore = pcall(require, "schemastore")
if not ok then
  vim.notify "schemastore could not be loaded"
  return
end

return {
  settings = {
    evenBetterToml = {
      schema = { catalogs = { "https://taplo.tamasfe.dev/schema_index.json" } },
    },
    toml = {
      schemas = schemastore.json.schemas(),
      validate = { enable = true },
    },
  },
  setup = {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
        end,
      },
    },
  },
}
