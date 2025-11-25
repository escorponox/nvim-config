return {
  "MagicDuck/grug-far.nvim",
  opts = { headerMaxWidth = 80 },
  cmd = "GrugFar",
  keys = {
    {
      "<leader>sr",
      function()
        local grug = require("grug-far")
        grug.open({
          transient = true,
        })
      end,
      mode = { "n", "v" },
      desc = "Search and Replace",
    },
    {
      "<leader>se",
      function()
        local grug = require("grug-far")
        local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
        grug.open({
          transient = true,
          prefills = {
            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
          },
        })
      end,
      mode = { "n", "v" },
      desc = "Search and Replace in extension",
    },
    {
      "<leader>sp",
      function()
        local grug = require("grug-far")
        local paths = vim.fn.expand("%:h")
        grug.open({
          transient = true,
          prefills = {
            paths = paths
          },
        })
      end,
      mode = { "n", "v" },
      desc = "Search and Replace in path",
    },
  },
}
