local opt = vim.opt

opt.showmode = false
opt.autowriteall = true
opt.autowrite = true
opt.clipboard = "unnamedplus"
opt.cursorline = true
opt.cursorlineopt = "number"
opt.writebackup = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2
opt.laststatus = 3
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
opt.foldcolumn = '1'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"
opt.number = true
opt.relativenumber = false
opt.numberwidth = 2
opt.ruler = false
opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.timeoutlen = 400
opt.undofile = true
opt.updatetime = 100
opt.wrap = false
opt.virtualedit = "block"
opt.termguicolors = true
opt.expandtab = true
opt.whichwrap:append("<>[]hl")
opt.cmdheight = 0
opt.scrolloff = 16
opt.sidescrolloff = 16

-- gui items
vim.opt.guifont = "Liga SFMono Nerd Font:h9"
