local ReloadGrp = vim.api.nvim_create_augroup('ReloadGroup', { clear = true })
vim.api.nvim_create_autocmd({ 'FocusGained' , 'BufEnter' }, {
  command = 'checktime',
  group = ReloadGrp
})

local GraphQLFiletypeGrp = vim.api.nvim_create_augroup('GraphQLFiletype', { clear = true })
vim.api.nvim_create_autocmd({ 'FocusGained' , 'BufEnter' }, {
  pattern = { '*.graphql', '*.graphqls', '*.gql' },
  command = 'setfiletype graphql',
  group = GraphQLFiletypeGrp
})
