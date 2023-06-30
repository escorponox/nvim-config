return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  version = false,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      config = function()
        require('telescope').load_extension('fzf')
      end
    },
    -- {
    --   'nvim-telescope/telescope-fzf-native.nvim',
    --   build =
    --   'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    -- },
  },
  config = function()
    local actions = require('telescope.actions')
    local builtin = require('telescope.builtin')

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
            ["<C-s>"] = actions.send_selected_to_qflist,
            ["s"] = actions.file_vsplit,
            ["t"] = actions.file_tab,
          },
        },
        vimgrep_arguments = {
          "rg",
          "--column",
          "--line-number",
          "--no-heading",
          "--ignore-case",
          "--color=never",
          "--glob",
          "!yarn.lock",
          "--glob",
          "!package-lock.json"
        }
      },
      pickers = {
        find_files = {
          find_command = {
            "rg",
            "--files",
            "--hidden",
            "--no-ignore",
            "--no-messages",
            "-g",
            "!node_modules/",
            "-g",
            "!.git/",
            "-g",
            "!yarn.lock",
            "-g",
            "!package-lock.json"
          }
        },
        quickfix = {
          show_line = false
        },
      },
      extensions = {
        fzf = {
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        },
      }
    }

    local function grep_string()
      builtin.grep_string({ search = vim.fn.input('Grep For > ') })
    end

    local function lsp_definitions()
      builtin.lsp_definitions({ jump_type = 'never', initial_mode = 'normal', show_line = false })
    end

    local function lsp_implementations()
      builtin.lsp_implementations({ jump_type = 'never', initial_mode = 'normal', show_line = false })
    end


    local function lsp_references()
      builtin.lsp_references({ jump_type = 'never', initial_mode = 'normal', show_line = false })
    end

    vim.keymap.set('n', ',ff', builtin.find_files)
    vim.keymap.set('n', ',fg', grep_string)
    vim.keymap.set('n', ',ft', builtin.grep_string)

    vim.keymap.set('n', ',fe', builtin.buffers)
    vim.keymap.set('n', ',fs', builtin.git_status)
    vim.keymap.set('n', ',fq', builtin.quickfix)


    vim.keymap.set('n', ',fr', lsp_references)
    vim.keymap.set('n', 'gd', lsp_definitions)
    vim.keymap.set('n', 'gi', lsp_implementations)
  end
}
