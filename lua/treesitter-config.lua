require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "css",
    "go",
    "graphql",
    "hcl",
    "html",
    "http",
    "javascript",
    "jsdoc",
    "json",
    "json5",
    "lua",
    "markdown",
    "perl",
    "prisma",
    "regex",
    "rust",
    "scss",
    "sql",
    "svelte",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vue",
    "yaml",
    "zig"
  }, -- one of "all" or a list of languages
  highlight = {
    enable = true, -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
  autotag = {
    enable = false -- sometimes it messes up the whole file
  },
  indent = {
    enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "Z", -- mapping to init the node/scope selection
      node_incremental = "gu", -- mapping to navigate nodes in current file
      node_decremental = "gd", -- mapping to navigate nodes in current file
    },
  },
}
