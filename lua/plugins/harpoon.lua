return {
  'ThePrimeagen/harpoon',
  lazy = true,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { ',ta', function() require('harpoon.mark').add_file() end,        desc = 'Harpoon add file' },
    { ',tm', function() require('harpoon.ui').toggle_quick_menu() end, desc = 'Harpoon add file' },
    { ',tj', function() require('harpoon.ui').nav_file(1) end,         desc = 'Harpoon add file' },
    { ',tk', function() require('harpoon.ui').nav_file(2) end,         desc = 'Harpoon add file' },
    { ',tl', function() require('harpoon.ui').nav_file(3) end,         desc = 'Harpoon add file' },
    { ',t;', function() require('harpoon.ui').nav_file(4) end,         desc = 'Harpoon add file' },
  },
}
