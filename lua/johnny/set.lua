vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.completeopt = "menu,menuone,noselect" --- Better autocompletion
vim.opt.cursorline = true --- Highlight of current line
vim.opt.ignorecase = true --- Needed for smartcase
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.list = false

vim.opt.tabstop = 2
vim.opt.smarttab = true
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.updatetime = 50
