local f = require("plugins.common.formatters")

return {
  "stevearc/conform.nvim",
  opts = {
    format_after_save = {
      lsp_fallback = true,
    },
    formatters_by_ft = f.conform_formatters(),
  },
}
