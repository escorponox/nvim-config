local f = require("plugins.common.formatters")

local slow_format_filetypes = {}

local function format_on_save(bufnr)
  if slow_format_filetypes[vim.bo[bufnr].filetype] then
    return
  end
  local function on_format(err)
    if err and err:match("timeout$") then
      slow_format_filetypes[vim.bo[bufnr].filetype] = true
    end
  end

  return { timeout_ms = 150, lsp_fallback = true }, on_format
end

return {
  "stevearc/conform.nvim",
  enabled = true,
  opts = {
    format_on_save = {
      timeout_ms = 2500,
      lsp_fallback = true,
      async = true,
    },
    formatters_by_ft = f.conform_formatters(),
  },
}
