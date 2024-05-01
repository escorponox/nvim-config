return {
  {
    "windwp/nvim-autopairs",
    enabled = true,
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "echasnovski/mini.pairs",
    enabled = false,
    version = false,
  },
}
