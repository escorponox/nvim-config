local function use_biome_if_installed_locally(bufnr)
  local biome_info = require("conform").get_formatter_info("biome", bufnr)
  if biome_info and biome_info.available and biome_info.command:match("node_modules/.bin/biome") then
    return { "biome", "biome-organize-imports" }
  end

  return { "prettier" }
end

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

return {
  "stevearc/conform.nvim",
  enabled = true,
  opts = {
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 2500, lsp_format = "fallback" }
    end,
    formatters_by_ft = {
      ["javascript"] = use_biome_if_installed_locally,
      ["javascriptreact"] = use_biome_if_installed_locally,
      ["typescript"] = use_biome_if_installed_locally,
      ["typescriptreact"] = use_biome_if_installed_locally,
      ["graphql"] = use_biome_if_installed_locally,
      ["vue"] = { "prettier" },
      ["css"] = use_biome_if_installed_locally,
      ["scss"] = { "prettier" },
      ["less"] = { "prettier" },
      ["html"] = { "prettier" },
      ["json"] = use_biome_if_installed_locally,
      ["jsonc"] = use_biome_if_installed_locally,
      ["yaml"] = { "prettier" },
      ["markdown"] = { "prettier" },
      ["markdown.mdx"] = { "prettier" },
      ["handlebars"] = { "prettier" },
      ["lua"] = { "stylua" },
    },
  },
}
