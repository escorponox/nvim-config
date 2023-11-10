return {
  "stevearc/dressing.nvim",
  opts = {
    select = {
      backend = "builtin",
      builtin = {
        relative = "cursor",
      },
    },
  },
  config = function(_, opts)
    require("dressing").setup(opts)
  end,
}
