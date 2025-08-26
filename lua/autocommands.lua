local ReloadGrp = vim.api.nvim_create_augroup("ReloadGroup", { clear = true })
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  command = "checktime",
  group = ReloadGrp,
})

local GraphQLFiletypeGrp = vim.api.nvim_create_augroup("GraphQLFiletype", { clear = true })
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  pattern = { "*.graphql", "*.graphqls", "*.gql" },
  command = "setfiletype graphql",
  group = GraphQLFiletypeGrp,
})

local HighlightYankGrp = vim.api.nvim_create_augroup("HighlightYank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = HighlightYankGrp,
  callback = function()
    vim.highlight.on_yank({ timeout = 500, hi_group = "IncSearch" })
  end,
})

-- vim.api.nvim_create_autocmd("ColorScheme", {
--   pattern = "kanagawa",
--   callback = function()
--     if vim.o.background == "light" then
--       vim.fn.system("kitty +kitten themes Kanagawa_light")
--     else
--       vim.fn.system("kitty +kitten themes Kanagawa")
--     end
--   end,
-- })

local ColorSchemeGrp = vim.api.nvim_create_augroup("ColorSchemeGrp", { clear = true })
vim.api.nvim_create_autocmd("OptionSet", {
  group = ColorSchemeGrp,
  pattern = "background",
  callback = function()
    if vim.o.background == "light" then
      vim.api.nvim_set_hl(0, "NeotestPassed", { fg = "#4F6F3E" })
      vim.api.nvim_set_hl(0, "NeotestFailed", { fg = "#D7005F" })
      vim.api.nvim_set_hl(0, "NeotestRunning", { fg = "#4C669F" })
      vim.api.nvim_set_hl(0, "NeotestSkipped", { fg = "#3A8D94" })
    else
      vim.api.nvim_set_hl(0, "NeotestPassed", { fg = "#A3BE8C" })
      vim.api.nvim_set_hl(0, "NeotestFailed", { fg = "#FF6C6B" })
      vim.api.nvim_set_hl(0, "NeotestRunning", { fg = "#81A1C1" })
      vim.api.nvim_set_hl(0, "NeotestSkipped", { fg = "#88C0D0" })
    end
  end,
})

vim.filetype.add({
  extension = {
    gotmpl = "gotmpl",
  },
  pattern = {
    [".*-deployments/.*/.*%.yaml"] = "helm", -- new pattern
    [".*/templates/.*%.tpl"] = "helm",
    [".*/templates/.*%.ya?ml"] = "helm",
    ["helmfile.*%.ya?ml"] = "helm",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact", "helm" },
  callback = function()
    vim.treesitter.start()
  end,
})
