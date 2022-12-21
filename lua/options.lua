vim.o.background = 'dark'
vim.g.gruvbox_italic = 1
vim.g.gruvbox_contrast_dark = 'hard'
vim.o.termguicolors = true
vim.cmd [[colorscheme gruvbox]]

vim.o.cursorline = true
vim.o.mouse = ''
vim.o.clipboard = 'unnamedplus'
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.linebreak = true
vim.o.backup = false
vim.o.swapfile = false
vim.o.showmode = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.o.splitright = true
vim.o.timeoutlen = 2000
vim.o.ttimeoutlen = 0
vim.o.updatetime = 100
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.showtabline = 2
vim.wo.scl = 'yes'
vim.o.backupcopy = 'yes'
vim.o.scrolloff = 8
vim.o.pumheight = 10

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.notify = require('notify')
