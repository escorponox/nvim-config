return {
  "mbbill/undotree",
  keys = {
    { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle undo tree" },
  },
  init = function()
    vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
  end,
}
