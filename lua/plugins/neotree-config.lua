return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = false,
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  keys = {
    {
      "-",
      function()
        require("neo-tree.command").execute({
          toggle = true,
          dir = vim.uv.cwd(),
        })
      end,
      desc = "Explorer NeoTree (cwd)",
    },
    {
      ",m",
      function()
        require("neo-tree.command").execute({
          toggle = true,
          reveal = true,
          dir = vim.uv.cwd(),
        })
      end,
      desc = "NeoTree FindFile (cwd)",
    },
    {
      ",,",
      function()
        require("neo-tree.command").execute({
          toggle = true,
          dir = vim.fn.expand("%:p:h"),
        })
      end,
      desc = "NeoTree File Folder",
    },
    {
      ",g",
      function()
        require("neo-tree.command").execute({
          source = "git_status",
          toggle = true,
          dir = vim.uv.cwd(),
        })
      end,
      desc = "NeoTree File Folder",
    },
  },
  opts = {
    sources = { "filesystem", "buffers", "git_status" },
    open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
    use_default_mappings = false,
    window = {
      width = 60,
    },
    enable_git_status = false,
    enable_diagnostics = false,
    enable_modified_markers = false,
    enable_opened_markers = false,
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = { enabled = false },
      use_libuv_file_watcher = true,
      window = {
        mappings = {
          ["o"] = { "open", config = { expand_nested_files = true } },
          ["<cr>"] = { "open", config = { expand_nested_files = true } },
          ["<esc>"] = "cancel",
          ["s"] = "open_vsplit",
          ["t"] = "open_tabnew",
          ["R"] = "refresh",
          ["a"] = {
            "add",
            -- some commands may take optional config options, see `:h neo-tree-mappings` for details
            config = {
              show_path = "none", -- "none", "relative", "absolute"
            },
          },
          ["d"] = "delete",
          ["r"] = "rename",
          ["y"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["c"] = "copy", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
          ["m"] = "move", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
          ["e"] = "toggle_auto_expand_width",
          ["q"] = "close_window",
          ["?"] = "show_help",
          ["H"] = "toggle_hidden",
          ["<bs>"] = "navigate_up",
        },
      },
    },
    git_status = {
      window = {
        position = "float",
        popup = { -- settings that apply to float position only
          size = {
            height = "80%",
            width = "50%",
          },
          position = "50%", -- 50% means center it
          -- you can also specify border here, if you want a different setting from
          -- the global popup_border_style.
        },
        mappings = {
          ["o"] = { "open", config = { expand_nested_files = true } },
          ["<cr>"] = { "open", config = { expand_nested_files = true } },
          ["<esc>"] = "cancel",
          ["s"] = "open_vsplit",
          ["t"] = "open_tabnew",
          ["R"] = "refresh",
        },
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
    },
    event_handlers = {

      {
        event = "file_opened",
        handler = function()
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
  },
}
