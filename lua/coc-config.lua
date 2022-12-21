vim.g.coc_global_extensions = { 'coc-json', 'coc-highlight', 'coc-tsserver', 'coc-eslint', 'coc-prettier', 'coc-yank',
  'coc-lists', 'coc-calc', 'coc-styled-components', 'coc-webpack', 'coc-sumneko-lua', 'coc-git', 'coc-go',
  'coc-rust-analyzer' }

vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
  group = "CocGroup",
  command = "silent call CocActionAsync('highlight')",
  desc = "Highlight symbol under cursor on CursorHold"
})

vim.keymap.set('n', ',fy', ':CocList yank<CR>')
vim.keymap.set('n', ',fh', ':call CocActionAsync(\'doHover\')<CR>')

vim.keymap.set('n', 'gd', ':call CocActionAsync(\'jumpDefinition\', v:false)<CR>')
vim.keymap.set('n', 'gt', ':call CocActionAsync(\'jumpTypeDefinition\', v:false)<CR>')
vim.keymap.set('n', 'gr', '<Plug>(coc-rename)')
vim.keymap.set('n', 'ga', '<Plug>(coc-codeaction-cursor)')
vim.keymap.set('n', 'gl', '<Plug>(coc-codeaction)')
vim.keymap.set('n', '<C-k>', '<Plug>(coc-diagnostic-prev)')
vim.keymap.set('n', '<C-j>', '<Plug>(coc-diagnostic-next)')

vim.keymap.set('n', '<leader>hj', '<Plug>(coc-git-nextchunk)', { silent = true })
vim.keymap.set('n', '<leader>hk', '<Plug>(coc-git-prevchunk)', { silent = true })
vim.keymap.set('n', '<leader>hi', ':CocCommand git.chunkInfo<CR>', { silent = true })
vim.keymap.set('n', '<leader>hu', ':CocCommand git.chunkUndo<CR>', { silent = true })

vim.keymap.set('n', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"',
  { expr = true, silent = true, nowait = true })
vim.keymap.set('n', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"',
  { expr = true, silent = true, nowait = true })
vim.keymap.set('i', '<C-CR>', 'coc#pum#confirm()', { expr = true, silent = true })
vim.keymap.set('i', '<C-space>', 'coc#refresh()', { expr = true, silent = true })

vim.keymap.set('n', ',ss', ':CocCommand session.save<CR>')
vim.keymap.set('n', ',ss', ':CocCommand session.load<CR>')
