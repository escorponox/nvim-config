local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('keymaps')

require('lazy').setup('plugins')

require('autocommands')
require('commands')

require('telescope-config')
require('tree-config')
require('treesitter-config')
require('lualine-config')
require('autopairs-config')
require('coc-config')

require('colorscheme')
require('options')
