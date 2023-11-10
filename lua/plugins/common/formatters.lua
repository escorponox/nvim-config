local M = {}

local prettier_ft = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "vue",
  "css",
  "scss",
  "less",
  "html",
  "json",
  "jsonc",
  "yaml",
  "markdown",
  "markdown.mdx",
  "graphql",
  "handlebars",
}

M.conform_formatters = function()
  local formatters = {
    ["lua"] = { "stylua" },
  }
  for _, ft in ipairs(prettier_ft) do
    formatters[ft] = { "prettier" }
  end
  return formatters
end

M.should_format_with_lsp = function(ft)
  for _, lsp in ipairs(prettier_ft) do
    if lsp == ft then
      return false
    end
  end
  if ft == "lua" then
    return false
  end

  return true
end

return M
