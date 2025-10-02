return {
  "tpope/vim-fugitive",
  enabled = true,
  lazy = false,
  keys = {
    { "gb", ":Git blame<CR>", desc = "Git blame" },
    -- { "gh", ":0Gclog<CR>:cclose<CR>", desc = "Git history" },
    { ",fh", ":vert Git log -p %<CR>", desc = "Git history" },
  },
}
