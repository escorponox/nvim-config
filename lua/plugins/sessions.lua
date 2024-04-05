local neotree_command = require("neo-tree.command")
local close_all_neotrees = function()
  local tabpages = vim.api.nvim_list_tabpages()
  local current_tabpage = vim.api.nvim_get_current_tabpage()

  for _, tabpage in ipairs(tabpages) do
    vim.api.nvim_set_current_tabpage(tabpage)
    neotree_command.execute({ action = "close" })
  end

  vim.api.nvim_set_current_tabpage(current_tabpage)
end

return {
  "echasnovski/mini.sessions",
  version = false,
  enabled = true,
  config = function()
    require("mini.sessions").setup({
      -- Whether to read latest session if Neovim opened without file arguments
      autoread = false,

      -- Whether to write current session before quitting Neovim
      autowrite = false,

      -- Directory where global sessions are stored (use `''` to disable)
      directory = vim.fn.stdpath("data") .. "/sessions",

      -- File for local session (use `''` to disable)
      file = "",

      -- Whether to force possibly harmful actions (meaning depends on function)
      force = { read = false, write = true, delete = false },

      -- Hook functions for actions. Default `nil` means 'do nothing'.
      hooks = {
        -- Before successful action
        pre = { read = nil, write = nil, delete = nil },
        -- After successful action
        post = { read = nil, write = nil, delete = nil },
      },

      -- Whether to print session path after action
      verbose = { read = true, write = true, delete = true },
    })

    local autoread = function()
      -- - There are files in arguments (like `nvim foo.txt` with new file).
      if vim.fn.argc() > 0 then
        return
      end
      local cwd = vim.loop.cwd()
      -- replace / with _ to avoid errors
      local clean_cwd = string.gsub(cwd, "/", "_")

      -- get detected sessions
      local detected_sessions = MiniSessions.detected

      local detected
      for key, s in pairs(detected_sessions) do
        -- replace / with _ to avoid errors
        if key == clean_cwd then
          detected = s
          break
        end
      end

      if detected then
        MiniSessions.read(detected.name)
      else
        MiniSessions.write(clean_cwd)
      end
    end

    local autowrite = function()
      local cwd = vim.loop.cwd()
      -- replace / with _ to avoid errors
      local clean_cwd = string.gsub(cwd, "/", "_")
      -- local tree_api = require("nvim-tree.api")

      -- get detected sessions
      local detected_sessions = MiniSessions.detected

      local detected
      for key, s in pairs(detected_sessions) do
        -- replace / with _ to avoid errors
        if key == clean_cwd then
          detected = s
          break
        end
      end

      if detected then
        -- tree_api.tree.close()
        close_all_neotrees()
        MiniSessions.write(clean_cwd)
      end
    end

    local augroup = vim.api.nvim_create_augroup("MiniSessions", {})
    vim.api.nvim_create_autocmd(
      "VimEnter",
      { group = augroup, nested = true, once = true, callback = autoread, desc = "Autoread latest session" }
    )
    vim.api.nvim_create_autocmd(
      "VimLeavePre",
      { group = augroup, callback = autowrite, desc = "Autowrite current session" }
    )
  end,
}
