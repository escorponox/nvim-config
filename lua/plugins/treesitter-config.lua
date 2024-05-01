return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  version = false,
  build = function()
    pcall(require("nvim-treesitter.install").update({ with_sync = true }))
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    {
      "nvim-treesitter/nvim-treesitter-context",
      opts = {
        max_lines = 2,
      },
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,

  opts = {
    textobjects = {
      select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
          ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
          ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop region" },
          ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop region" },
          ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional region" },
          ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional region" },
        },
        -- If you set this to `true` (default is `false`) then any textobject is
        -- extended to include preceding or succeeding whitespace. Succeeding
        -- whitespace has priority in order to act similarly to eg the built-in
        -- `ap`.
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * selection_mode: eg 'v'
        -- and should return true of false
        include_surrounding_whitespace = true,
      },
    },
    ensure_installed = {
      "bash",
      "css",
      "go",
      "graphql",
      "hcl",
      "helm",
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
      "terraform",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vue",
      "yaml",
      "zig",
    }, -- one of "all" or a list of languages
    highlight = {
      enable = true, -- false will disable the whole extension
      additional_vim_regex_highlighting = false,
    },
    autotag = {
      enable = false, -- sometimes it messes up the whole file
    },
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = false,
      -- keymaps = {
      --   init_selection = "Z", -- mapping to init the node/scope selection
      --   node_incremental = "gu", -- mapping to navigate nodes in current file
      --   node_decremental = "gd", -- mapping to navigate nodes in current file
      -- },
    },
  },
}
