vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")


-- quick fix maps
vim.keymap.set("n", "<M-Down>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-Up>", "<cmd>cprev<CR>")
