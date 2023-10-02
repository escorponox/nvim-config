local scheme = "kanagawa"


if scheme == "gruvbox" then
  return {
    'gruvbox-community/gruvbox',
    init = function()
      vim.o.background = 'dark'
      vim.g.gruvbox_italic = 1
      vim.g.gruvbox_contrast_dark = 'hard'
    end,
    config = function()
      vim.cmd.colorscheme "gruvbox"
      vim.api.nvim_set_hl(0, "NvimTreeRootFolder", { link = "GruvBoxPurple" })
      vim.api.nvim_set_hl(0, "NvimTreeFolderName", { link = "GruvBoxAqua" })
      vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { link = "GruvBoxGreen" })
      vim.api.nvim_set_hl(0, "NvimTreeEmpyFolderName", { link = "GruvBoxGray" })
      vim.api.nvim_set_hl(0, "NvimTreeGitIgnored", { link = "GruvBoxGray" })
      vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { link = "GruvBoxOrange" })
    end

  }
elseif scheme == "catppuccin" then
  return {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "macchiato",
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
      }
    },
    config = function(_, opts)
      vim.o.background = 'dark'
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme "catppuccin"
    end

  }
elseif scheme == "kanagawa" then
  return {
    "rebelot/kanagawa.nvim",
    config = function(_, opts)
      vim.o.background = 'dark'
      require("kanagawa").setup(opts)
      vim.cmd.colorscheme "kanagawa"
    end

  }
end
