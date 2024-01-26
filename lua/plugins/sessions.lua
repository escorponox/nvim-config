return {
  "echasnovski/mini.sessions",
  version = false,
  enabled = true,
  config = function()
    require("mini.sessions").setup({
      -- Whether to read latest session if Neovim opened without file arguments
      autoread = false,

      -- Whether to write current session before quitting Neovim
      autowrite = true,

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
  end,
}
