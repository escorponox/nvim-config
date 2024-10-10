local function use_biome_if_installed_locally(bufnr)
  local biome_info = require("conform").get_formatter_info("biome", bufnr)
  if biome_info and biome_info.available and biome_info.command:match("node_modules/.bin/biome") then
    return { "biome" }
  end

  return { "prettier" }
end

return {
  "stevearc/conform.nvim",
  enabled = true,
  opts = {
    format_on_save = {
      timeout_ms = 2500,
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      ["javascript"] = use_biome_if_installed_locally,
      ["javascriptreact"] = use_biome_if_installed_locally,
      ["typescript"] = use_biome_if_installed_locally,
      ["typescriptreact"] = use_biome_if_installed_locally,
      ["vue"] = { "prettier" },
      ["css"] = { "prettier" },
      ["scss"] = { "prettier" },
      ["less"] = { "prettier" },
      ["html"] = { "prettier" },
      ["json"] = { "prettier" },
      ["jsonc"] = { "prettier" },
      ["yaml"] = { "prettier" },
      ["markdown"] = { "prettier" },
      ["markdown.mdx"] = { "prettier" },
      ["graphql"] = { "prettier" },
      ["handlebars"] = { "prettier" },
      ["lua"] = { "stylua" },
    },
  },
}
