local ReloadGrp = vim.api.nvim_create_augroup('ReloadGroup', { clear = true })
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  command = 'checktime',
  group = ReloadGrp
})

local GraphQLFiletypeGrp = vim.api.nvim_create_augroup('GraphQLFiletype', { clear = true })
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  pattern = { '*.graphql', '*.graphqls', '*.gql' },
  command = 'setfiletype graphql',
  group = GraphQLFiletypeGrp
})

local HighlightYankGrp = vim.api.nvim_create_augroup('HighlightYank', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = HighlightYankGrp,
  callback = function()
    vim.highlight.on_yank({ timeout = 500, hi_group = 'IncSearch' })
  end,
})
