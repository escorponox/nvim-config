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
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
  }
})
vim.cmd.colorscheme "catppuccin"
-- vim.cmd.colorscheme "gruvbox"
-- vim.cmd.colorscheme "kanagawa-wave"
