local create_cmd = vim.api.nvim_create_user_command

create_cmd("DuplicateLine", function(opts)
  vim.cmd("-" .. opts.args .. ",-0t.")
end, { nargs = 1 })

create_cmd("CopyLine", function(opts)
  vim.cmd("-" .. opts.args .. ",-" .. opts.args .. "t.")
end, { nargs = 1 })

create_cmd("ToggleBackground", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end, {})
