-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

-- plugins
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'gruvbox-community/gruvbox'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }

  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  use {
    'nvim-treesitter/nvim-treesitter-context',
    after = 'nvim-treesitter',
  }

  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }
  --use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }
  use { 'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  use 'ilAYAli/scMRU.nvim'

  use('mbbill/undotree')
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-commentary'
  use 'towolf/vim-helm'
  --use 'lewis6991/gitsigns.nvim'

  use 'nvim-lualine/lualine.nvim'
  use 'windwp/nvim-autopairs'

  use 'kyazdani42/nvim-tree.lua'

  use 'github/copilot.vim'

  use { 'neoclide/coc.nvim', branch = 'release' }
  use 'escorponox/telescope-coc.nvim'

  use 'rcarriga/nvim-notify'

end)

require('options')
require('autocommands')
require('keymaps')
require('commands')

require('telescope-config')
require('tree-config')
require('treesitter-config')
require('lualine-config')
require('nvim-autopairs').setup()

require('coc-config')
