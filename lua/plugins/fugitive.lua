return {
  "tpope/vim-fugitive",
  enabled = true,
  keys = {
    { "gb", ":Git blame<CR>", desc = "Git blame" },
    { "gh", ":0Gclog<CR>:cclose<CR>", desc = "Git history" },
  },
}
