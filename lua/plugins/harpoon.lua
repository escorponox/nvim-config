return {
  "ThePrimeagen/harpoon",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  --stylua: ignore
  keys = {
    { ',ta', function() require('harpoon.mark').add_file() end,        desc = 'Harpoon add file' },
    { ',tm', function() require('harpoon.ui').toggle_quick_menu() end, desc = 'Harpoon menu' },
    { ',tj', function() require('harpoon.ui').nav_file(1) end,         desc = 'Harpoon file 1' },
    { ',tk', function() require('harpoon.ui').nav_file(2) end,         desc = 'Harpoon file 2' },
    { ',tl', function() require('harpoon.ui').nav_file(3) end,         desc = 'Harpoon file 3' },
    { ',t;', function() require('harpoon.ui').nav_file(4) end,         desc = 'Harpoon file 4' },
  },
}
