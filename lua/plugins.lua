return {
  'gruvbox-community/gruvbox',
  { "catppuccin/nvim",                          name = "catppuccin" },
  -- "rebelot/kanagawa.nvim",
  {
    'nvim-treesitter/nvim-treesitter',
    build = function() pcall(require('nvim-treesitter.install').update { with_sync = true }) end,
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects', 'nvim-treesitter/nvim-treesitter-context' }
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  -- {
  --   'nvim-telescope/telescope-fzf-native.nvim',
  --   build =
  --   'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  -- },
  'ilAYAli/scMRU.nvim',
  'mbbill/undotree',
  'tpope/vim-fugitive',
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'tpope/vim-commentary',
  'towolf/vim-helm',
  'nvim-lualine/lualine.nvim',
  'windwp/nvim-autopairs',
  'kyazdani42/nvim-tree.lua',
  'github/copilot.vim',
  { 'neoclide/coc.nvim', branch = 'release' },
  'escorponox/telescope-coc.nvim',
  'rcarriga/nvim-notify',

}
