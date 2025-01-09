local keymap = vim.keymap.set

keymap({ "n", "v" }, "<leader><leader>x", "<cmd>source %<CR>")
keymap("n", "<leader>x", ":.lua<CR>")
keymap("v", "<leader>x", ":lua<CR>")

keymap({ "n", "v" }, "<A-Left>", "<C-w><C-t>")
keymap({ "n", "v" }, "<A-Right>", "<C-w><C-w>")

-- quick fix maps
keymap("n", "<M-Down>", "<cmd>cnext<CR>")
keymap("n", "<M-Up>", "<cmd>cprev<CR>")
