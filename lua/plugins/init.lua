return {
  require('plugins.colorscheme'),
  require('plugins.treesitter-config'),
  require('plugins.telescope-config'),
  require('plugins.mru-config'),
  require('plugins.undo-tree-config'),
  require('plugins.autopairs-config'),


  require('plugins.git-signs-config'),
  require('plugins.lualine-config'),
  require('plugins.tree-config'),


  require('plugins.notify-config'),
  require('plugins.dressing-config'),
  require('plugins.illuminate-config'),

  require('plugins.lsp-config'),
  require('plugins.cmp-config'),
  require('plugins.dap-config'),

  {
    'tpope/vim-fugitive',
    enabled = false,
    keys = {
      { "gb", ":Git blame<CR>", desc = "Git blame" }
    }
  },
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'tpope/vim-commentary',
  'towolf/vim-helm',
  'github/copilot.vim',
}
