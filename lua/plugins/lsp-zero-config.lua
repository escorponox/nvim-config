return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v3.x",
  enabled = true,
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lsp_zero = require("lsp-zero")
    local lspconfig = require("lspconfig")

    -- Global mappings
    vim.keymap.set("n", "<C-k>", vim.diagnostic.goto_prev)
    vim.keymap.set("n", "<C-j>", vim.diagnostic.goto_next)
    vim.keymap.set("n", "<C-h>", function()
      vim.lsp.inlay_hint(0, nil)
    end, { desc = "Toggle Inlay Hints" })

    lsp_zero.on_attach(function(_, bufnr)
      -- see :help lsp-zero-keybindings
      -- to learn the available actions
      lsp_zero.default_keymaps({
        buffer = bufnr,
        exclude = { "gd", "gr", "gi" },
      })

      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set("n", "gr", vim.lsp.buf.rename, bufopts)
      vim.keymap.set("n", "ga", vim.lsp.buf.code_action, bufopts)
    end)

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = false

    -- lua
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim" } },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
    })

    -- tailwindCSS
    lspconfig.tailwindcss.setup({
      settings = {
        tailwindCSS = {
          experimental = {
            classRegex = {
              { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
              { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
            },
          },
        },
      },
    })

    lspconfig.tsserver.setup({})
  end,
}
