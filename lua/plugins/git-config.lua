local prevFocusedWindow = nil

return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs = require("gitsigns")

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "<leader>hj", function()
          gs.nav_hunk("next")
        end)

        map("n", "<leader>hk", function()
          gs.nav_hunk("prev")
        end)

        -- focus on the current hunk preview
        map("n", "<leader>hp", function()
          local windows = vim.api.nvim_tabpage_list_wins(0)
          local preview_window = nil

          for _, win in ipairs(windows) do
            local win_info = vim.api.nvim_win_get_config(win)
            if win_info.relative == "win" and win_info.focusable then
              preview_window = win
              break
            end
          end

          if preview_window then
            prevFocusedWindow = vim.api.nvim_get_current_win()
            vim.api.nvim_set_current_win(preview_window)

            vim.keymap.set("n", "<leader>hp", function()
              vim.api.nvim_set_current_win(prevFocusedWindow)
              prevFocusedWindow = nil
            end, {
              noremap = true,
              silent = true,
              buffer = vim.api.nvim_win_get_buf(preview_window),
            })
          else
            -- Notify the user if no preview window is found
            vim.notify("No preview window found", vim.log.levels.WARN)
          end
        end)

        -- Actions
        map({ "n", "v" }, "<leader>hh", gs.preview_hunk)
        map({ "n", "v" }, "<leader>hi", gs.preview_hunk_inline)
        map({ "n", "v" }, "<leader>hu", gs.reset_hunk)
        -- map("n", 'gb', gs.blame_line)
      end,
    },
  },
  {
    "tpope/vim-fugitive",
    enabled = true,
    lazy = false,
    keys = {
      { "gb", ":Git blame<CR>", desc = "Git blame" },
      -- { "gh", ":0Gclog<CR>:cclose<CR>", desc = "Git history" },
      { ",fh", ":vert Git log -p %<CR>", desc = "Git history" },
    },
  },
  "sindrets/diffview.nvim",
}
