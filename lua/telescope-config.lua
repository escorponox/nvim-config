local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    layout_config = {
      horizontal = {
        prompt_position = 'top',
        preview_width = 0.4
      }
    },
    sorting_strategy = "ascending",
    mappings = {
      i = {
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-s>"] = actions.send_selected_to_qflist
      },
      n = {
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-s>"] = actions.send_selected_to_qflist
      },
    },
  },
  extensions = {
    fzf = {
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
  }
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('coc')

local builtin = require('telescope.builtin')
local rgOptions = { "rg", "--column", "--line-number", "--no-heading", "--ignore-case", "--color=never", "--glob",
  "!yarn.lock", "--glob", "!package-lock.json" }
local function find_files()
  builtin.find_files({ find_command = { "rg", "--files", "--hidden", "--no-ignore", "--no-messages", "-g",
    "!node_modules/", "-g", "!.git/", "-g", "!yarn.lock", "-g", "!package-lock.json" } })
end

local function grep_string()
  builtin.grep_string({ search = vim.fn.input('Grep For > '), vimgrep_arguments = rgOptions })
end

local function find_word()
  builtin.grep_string({ vimgrep_arguments = rgOptions })
end

vim.keymap.set('n', ',ff', find_files)
vim.keymap.set('n', ',fg', grep_string)
vim.keymap.set('n', ',ft', find_word)

vim.keymap.set('n', ',fe', ':Telescope buffers<CR>')
vim.keymap.set('n', ',fs', ':Telescope git_status<CR>')
vim.keymap.set('n', ',fr', ':Telescope coc references<CR>')
vim.keymap.set('n', ',fq', ':Telescope quickfix<CR>')
