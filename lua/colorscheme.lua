vim.o.background = 'dark'
vim.g.gruvbox_italic = 1
vim.g.gruvbox_contrast_dark = 'hard'
vim.o.termguicolors = true


require("catppuccin").setup({
  flavour = "macchiato",
  integrations = {
    coc_nvim = true,
    nvimtree = true,
    notify = true,
  }
})
vim.cmd.colorscheme "catppuccin"
-- vim.cmd.colorscheme "gruvbox"
