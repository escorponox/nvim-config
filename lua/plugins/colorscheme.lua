local gruvbox = {
  "gruvbox-community/gruvbox",
  init = function()
    vim.o.background = "dark"
    vim.g.gruvbox_italic = 1
    vim.g.gruvbox_contrast_dark = "hard"
  end,
  config = function()
    vim.cmd.colorscheme("gruvbox")
    vim.api.nvim_set_hl(0, "NvimTreeRootFolder", { link = "GruvBoxPurple" })
    vim.api.nvim_set_hl(0, "NvimTreeFolderName", { link = "GruvBoxAqua" })
    vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { link = "GruvBoxGreen" })
    vim.api.nvim_set_hl(0, "NvimTreeEmpyFolderName", { link = "GruvBoxGray" })
    vim.api.nvim_set_hl(0, "NvimTreeGitIgnored", { link = "GruvBoxGray" })
    vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { link = "GruvBoxOrange" })
  end,
}
local catppuccin = {
  "catppuccin/nvim",
  name = "catppuccin",
  opts = {
    flavour = "latte",
    integrations = {
      coc_nvim = true,
      nvimtree = true,
      notify = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
      },
      dap = {
        enabled = true,
        enable_ui = true,
      },
    },
  },
  config = function(_, opts)
    vim.o.background = "dark"
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}

local kanagawa = {
  "rebelot/kanagawa.nvim",
  enabled = false,
  opts = {
    compile = false, -- enable compiling the colorscheme
    undercurl = true, -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false, -- do not set background color
    dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    terminalColors = true, -- define vim.g.terminal_color_{0,17}
    colors = { -- add/modify theme and palette colors
      palette = {},
      theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    },
    overrides = function() -- add/modify highlights
      return {}
    end,
    theme = "wave", -- Load "wave" theme when 'background' option is not set
    background = { -- map the value of 'background' option to a theme
      dark = "wave", -- try "dragon" !
      light = "lotus",
    },
  },
  config = function(_, opts)
    require("kanagawa").setup(opts)
    vim.cmd.colorscheme("kanagawa")
  end,
}

local tokyonight = {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "storm",
    light_style = "day",
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight")
  end,
}

return catppuccin
