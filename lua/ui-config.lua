require('illuminate').configure({
  providers = { 'treesitter' },
  delay = 200,
})

vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#8AADF4", fg = "#24273A" })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#A6DA95", fg = "#24273A" })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#ED8796", fg = "#24273A" })

require('dressing').setup({
  select = {
    backend = 'builtin',
    builtin = {
      relative = 'cursor',
    },
  }
})

