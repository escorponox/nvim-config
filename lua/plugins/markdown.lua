return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
    opts = {},
    ft = "markdown",
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
  },

  {
    "davidmh/mdx.nvim",
    enabled = false,
    config = true,
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
}
