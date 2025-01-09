local function open_quickfix_in_floating_window()
  -- Get the current quickfix list

  -- Create a new buffer for the floating window
  local buf = vim.api.nvim_create_buf(false, true)

  -- Set the buffer content to the quickfix list
  local lines = {}
  for _, item in ipairs(qflist) do
    table.insert(lines, item.text)
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Define the floating window dimensions and position
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Open the floating window
  vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'single'
  })
end


local function add_lsp_diagnostics_to_qf()
  -- Retrieve all LSP diagnostics
  local all_diagnostics = vim.diagnostic.get()
  local qf_items = {}

  -- Iterate over each buffer's diagnostics
  for bufnr, diagnostics in pairs(all_diagnostics) do
    for _, diagnostic in ipairs(diagnostics) do
      if diagnostic.severity == vim.lsp.protocol.DiagnosticSeverity.Warning or
          diagnostic.severity == vim.lsp.protocol.DiagnosticSeverity.Error then
        -- Add diagnostic to quickfix list
        table.insert(qf_items, {
          bufnr = bufnr,
          lnum = diagnostic.range.start.line + 1,
          col = diagnostic.range.start.character + 1,
          text = diagnostic.message,
          type = diagnostic.severity == vim.lsp.protocol.DiagnosticSeverity.Warning and 'W' or 'E'
        })
      end
    end
  end

  -- Set the quickfix list with the filtered diagnostics
  vim.fn.setqflist({}, 'r', { title = 'LSP Diagnostics', items = qf_items })
  print(vim.inspect(qf_items))
  if vim.tbl_isempty(qf_items) then
    vim.notify("Quickfix list is empty")
    return
  end


  open_quickfix_in_floating_window()
end

vim.keymap.set('n', '<leader>wd', function() add_lsp_diagnostics_to_qf() end, { noremap = true, silent = true })
