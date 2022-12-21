vim.api.nvim_create_user_command(
  'DuplicateLine',
  function(opts)
    vim.cmd('-' .. opts.args .. ',-0t.')
  end,
  { nargs = 1 }
)

vim.api.nvim_create_user_command(
  'CopyLine',
  function(opts)
    vim.cmd('-' .. opts.args .. ',-' .. opts.args .. 't.')
  end,
  { nargs = 1 }
)
