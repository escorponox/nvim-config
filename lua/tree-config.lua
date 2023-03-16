local luv = vim.loop
local reloaders = require 'nvim-tree.actions.reloaders.reloaders'
local api = require 'nvim-tree.api'

local template_fn = function(command)
  return function(node)
    local process = {
      cmd = command,
      args = {},
      errors = '\n',
      stderr = luv.new_pipe(false)
    }

    local s = vim.fn.input("New " .. command .. ": ", "")
    local path = vim.fn.fnamemodify(node.absolute_path, ':p:h')
    process.handle, process.pid = luv.spawn(process.cmd,
      {
        args = { s },
        stdio = { nil, nil, process.stderr },
        detached = true,
        cwd = path
      },
      function(code)
        process.stderr:read_stop()
        process.stderr:close()
        process.handle:close()
        if code ~= 0 then
          process.errors = process.errors .. string.format('NvimTree system_open: return code %d.', code)
          error(process.errors)
        else
          vim.schedule_wrap(reloaders.reload_explorer)()
        end
      end
    )
    table.remove(process.args)
    if not process.handle then
      error("\n" .. process.pid .. "\nNvimTree system_open: failed to spawn process using '" .. process.cmd .. "'.")
      return
    end
    luv.read_start(process.stderr,
      function(err, data)
        if err then return end
        if data then process.errors = process.errors .. data end
      end
    )
    luv.unref(process.handle)
  end
end

vim.api.nvim_set_hl(0, "NvimTreeRootFolder", { link = "GruvBoxPurple" })
vim.api.nvim_set_hl(0, "NvimTreeFolderName", { link = "GruvBoxAqua" })
vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { link = "GruvBoxGreen" })
vim.api.nvim_set_hl(0, "NvimTreeEmpyFolderName", { link = "GruvBoxGray" })
vim.api.nvim_set_hl(0, "NvimTreeGitIgnored", { link = "GruvBoxGray" })
vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { link = "GruvBoxOrange" })

require 'nvim-tree'.setup {
  git = {
    enable = false,
    ignore = false
  },
  actions = {
    open_file = {
      quit_on_open = true
    },
  },
  renderer = {
    special_files = { 'package.json', '.env' },
    icons = {
      padding = '',
      show = {
        file = false,
        folder = true,
        folder_arrow = true,
        git = false,
      },
      glyphs = {
        default = '',
        symlink = '',
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌"
        },
        folder = {
          arrow_open = "▾",
          arrow_closed = "▸",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = ""
        }
      }
    }
  },
  view = {
    width = 60,
  },
  on_attach = function(bufnr)
    local inject_node = require("nvim-tree.utils").inject_node
    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    vim.keymap.set("n", "s", api.node.open.vertical, { buffer = bufnr })
    vim.keymap.set("n", "t", api.node.open.tab, { buffer = bufnr })
    vim.keymap.set("n", "<leader>cc", inject_node(template_fn("component")), { buffer = bufnr })
    vim.keymap.set("n", "<leader>ch", inject_node(template_fn("hook")), { buffer = bufnr })
    vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
    vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
    vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts('Info'))
    vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
    vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
    vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
    vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
    vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
    vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
    vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
    vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
    vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
    vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
    vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
    vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
    vim.keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opts('Toggle No Buffer'))
    vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
    vim.keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opts('Toggle Git Clean'))
    vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
    vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
    vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
    vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
    vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
    vim.keymap.set('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
    vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
    vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
    vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
    vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
    vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
    vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
    vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
    vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
    vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
    vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
    vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
    vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
    vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
    vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
    vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
    vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
    vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
    -- vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
    vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
    vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
    vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
    vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
    vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
    vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
    vim.bo[bufnr].path = "/tmp"
  end
}

vim.keymap.set('n', ',m', ':NvimTreeToggle<CR>')
vim.keymap.set('n', ',,', ':NvimTreeFindFileToggle<CR>')
