local function setqflist(items)
  local qf = {} ---@type vim.quickfix.entry[]
  for _, item in ipairs(items) do
    qf[#qf + 1] = {
      filename = Snacks.picker.util.path(item),
      bufnr = item.buf,
      lnum = item.pos and item.pos[1] or 1,
      col = item.pos and item.pos[2] + 1 or 1,
      end_lnum = item.end_pos and item.end_pos[1] or nil,
      end_col = item.end_pos and item.end_pos[2] + 1 or nil,
      text = item.line or item.comment or item.label or item.name or item.detail or item.text,
      pattern = item.search,
      valid = true,
    }
  end
  vim.fn.setqflist(qf)
end

local function get_tabs()
  local tabs = {}
  local tabpages = vim.api.nvim_list_tabpages()
  for i, tabpage in ipairs(tabpages) do
    local wins = vim.api.nvim_tabpage_list_wins(tabpage)
    local cur_win = vim.api.nvim_tabpage_get_win(tabpage)
    local buf = vim.api.nvim_win_get_buf(cur_win)
    local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
    if name == "" then
      name = "[No Name]"
    end

    local preview_lines = {}
    table.insert(preview_lines, ("Tab %d: %d window%s"):format(i, #wins, #wins == 1 and "" or "s"))
    table.insert(preview_lines, ("%-6s %-8s %s"):format("WinID", "Buf#", "File"))
    table.insert(preview_lines, string.rep("-", 40))
    for _, win in ipairs(wins) do
      local win_buf = vim.api.nvim_win_get_buf(win)
      local bufname = vim.api.nvim_buf_get_name(win_buf)
      if bufname == "" then
        bufname = "[No Name]"
      end
      bufname = vim.fn.fnamemodify(bufname, ":~:.") -- relative to cwd, or ~
      local win_marker = (win == cur_win) and "->" or "  "
      table.insert(preview_lines, ("%s %-6d %-8d %s"):format(win_marker, win, win_buf, bufname))
    end
    if #wins == 0 then
      table.insert(preview_lines, "No windows in tab")
    end

    table.insert(tabs, {
      idx = i,
      text = ("Tab %d: %s"):format(i, name),
      tabnr = i,
      tabpage = tabpage,
      preview = {
        text = table.concat(preview_lines, "\n"),
        ft = "text",
      },
    })
  end
  return tabs
end

return {
  "folke/snacks.nvim",
  lazy = false,
  opts = {
    input = {
      -- your input configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      enabled = true,
    },
    styles = {
      input = {
        border = "single",
        relative = "cursor",
        row = -3,
        col = 0,
      },
    },
    picker = {
      ui_select = true,
      formatters = {
        file = {
          filename_first = true, -- display filename before the file path
          truncate = 80, -- truncate the file path to (roughly) this length
          filename_only = false, -- only show the filename
          icon_width = 2, -- width of the icon (in characters)
          git_status_hl = true, -- use the git status highlight group for the filename
        },
      },
      layouts = {
        select = {
          layout = {
            relative = "cursor",
            width = 70,
            min_width = 0,
            row = 1,
          },
        },
      },
      win = {
        input = {
          keys = {
            ["s"] = { "edit_vsplit", mode = { "n" } },
            ["t"] = { "tab", mode = { "n" } },
            ["<c-v>"] = { "edit_vsplit", mode = { "i" } },
            ["<c-t>"] = { "tab", mode = { "i" } },
            ["<c-q>"] = { "to_qflist", mode = { "i", "n" } },
          },
        },
        list = {
          keys = {
            ["s"] = { "edit_vsplit", mode = { "n" } },
            ["t"] = { "tab", mode = { "n" } },
            ["<c-q>"] = { "to_qflist", mode = { "i", "n" } },
          },
        },
      },
      actions = {
        to_qflist = function(picker)
          picker:close()
          local sel = picker:selected()
          local items = #sel > 0 and sel or picker:items()
          setqflist(items)
        end,
      },
    },
  },
  -- stylua: ignore
  keys = {
    -- resume
    { ",fR", function() Snacks.picker.resume() end, desc = "Resume" },

    -- pickers
    { ",fp", function() Snacks.picker.pickers() end, desc = "Pickers" },

    -- files
    { ",ff", function() Snacks.picker.files({ hidden = true }) end, desc = "Find Files", },
    { ",fm", function() Snacks.picker.recent({ filter = { cwd = true }}) end, desc = "Recent", },
    { ",fe", function() Snacks.picker({
  title = "Tabs",
  items = get_tabs(),
  format = "text",
  confirm = function(picker, item)
    picker:close()
    vim.cmd(("tabnext %d"):format(item.tabnr))
  end,
  preview = "preview",
  actions = {
    close_tab = function(picker, item)
      picker:close()
      vim.cmd(("tabclose %d"):format(item.tabnr))
    end,
  },
  win = {
    input = {
      keys = {
        ["d"] = "close_tab",
      },
    },
  },
}) end, desc = "Buffers" },

    -- grep
    { ",fg", function() Snacks.picker.grep() end, desc = "Live Grep" },
    { ",ft", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },

    -- git
    { ",fs", function() Snacks.picker.git_status() end, desc = "Git Status" },

    -- quickfix
    { ",fq", function() Snacks.picker.qflist() end, desc = "Quickfix" },

    -- lsp
    { ",fr", function() Snacks.picker.lsp_references({ focus = "list", auto_confirm = false }) end, desc = "LSP References" },
    { "gd", function() Snacks.picker.lsp_definitions({ focus = "list", auto_confirm = false }) end, desc = "LSP Definitions" },
    { "gi", function() Snacks.picker.lsp_implementations({ focus = "list", auto_confirm = false }) end, desc = "LSP Implementations" },

    -- keymaps
    { ",fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" }
  },
}
