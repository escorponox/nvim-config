local new_config = {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter")
    -- treesitter.setup({
    --   -- Directory to install parsers and queries to
    --   install_dir = vim.fn.stdpath("data") .. "/site",
    -- })

    treesitter.install({
      "bash",
      "css",
      "dockerfile",
      "git_config",
      "gitignore",
      "go",
      "graphql",
      "hcl",
      "helm",
      "html",
      "http",
      "javascript",
      "jsdoc",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "regex",
      "rust",
      "terraform",
      "toml",
      "tsx",
      "typescript",
      "yaml",
    })
  end,
}

return new_config
