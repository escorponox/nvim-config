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

-- local ColorSchemeGrp = vim.api.nvim_create_augroup("ColorSchemeGrp", { clear = true })
-- vim.api.nvim_create_autocmd("OptionSet", {
--   group = ColorSchemeGrp,
--   pattern = "background",
--   callback = function()
--     if vim.o.background == "light" then
--       vim.cmd.colorscheme("tokyonight-day")
--     else
--       vim.cmd.colorscheme("kanagawa")
--     end
--   end,
-- })
