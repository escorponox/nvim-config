return {
  "neovim/nvim-lspconfig",
  enabled = true,
  event = { "BufReadPre", "BufNewFile" },
  init = function()
    local lspconfig = require("lspconfig")

    local function goto_next_diagnostic()
      vim.diagnostic.jump({ count = 1, float = true })
    end
    local function goto_prev_diagnostic()
      vim.diagnostic.jump({ count = -1, float = true })
    end

    vim.diagnostic.config({
      virtual_text = true,
      -- virtual_lines = { current_line = true },
    })

    -- Global mappings

    vim.keymap.set("n", "<C-k>", goto_prev_diagnostic)
    vim.keymap.set("n", "<C-j>", goto_next_diagnostic)

    vim.keymap.set("n", "<C-h>", function()
      vim.lsp.inlay_hint(0, nil)
    end, { desc = "Toggle Inlay Hints" })

    -- Add cmp_nvim_lsp capabilities settings to lspconfig
    -- This should be executed before you configure any language server
    local lspconfig_defaults = require("lspconfig").util.default_config

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = false

    lspconfig_defaults.capabilities = vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, capabilities)

    -- vim.api.nvim_create_autocmd("LspAttach", {
    --   callback = function(ev)
    --     vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    --     local client = vim.lsp.get_client_by_id(ev.data.client_id)

    --     if client ~= nil and client.name == "gopls" then
    --       if not client.server_capabilities.semanticTokensProvider then
    --         local semantic = client.config.capabilities.textDocument.semanticTokens
    --         if semantic ~= nil then
    --           client.server_capabilities.semanticTokensProvider = {
    --             full = true,
    --             legend = {
    --               tokenTypes = semantic.tokenTypes,
    --               tokenModifiers = semantic.tokenModifiers,
    --             },
    --             range = true,
    --           }
    --         end
    --       end
    --     end
    --   end,
    -- })

    -- lua
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim", "sbar" } },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
    })
    vim.lsp.enable("lua_ls")

    -- tailwindCSS
    vim.lsp.config("tailwindcss", {
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
    vim.lsp.enable("tailwindcss")

    vim.lsp.config("ts_ls", {
      init_options = {
        preferences = {
          importModuleSpecifierPreference = "shortest",
        },
      },
    })
    vim.lsp.enable("ts_ls")

    vim.lsp.enable("biome")

    -- Golang
    vim.lsp.config("gopls", {
      cmd = { "gopls" },
      capabilities = capabilities,
      settings = {
        gopls = {
          gofumpt = true,
          staticcheck = true,
          usePlaceholders = true,
          completeUnimported = true,
          directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
          semanticTokens = true,
          analyses = {
            shadow = true,
            fieldalignment = true,
            nilness = true,
            unusedparams = true,
            unusedwrite = true,
            useany = true,
          },
          hints = {
            parameterNames = true,
            functionTypeParameters = true,
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            rangeVariableTypes = true,
          },
          codelenses = {
            gc_details = false,
            generate = true,
            regenerate_cgo = true,
            run_govulncheck = true,
            test = true,
            tidy = true,
            upgrade_dependency = true,
            vendor = true,
          },
        },
      },
      init_options = { usePlaceholders = true },
    })
    vim.lsp.enable("gopls")

    -- lspconfig.rust_analyzer.setup({
    --   on_attach = function(_, bufnr)
    --     vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    --   end,
    -- })

    vim.lsp.enable("helm_ls")

    -- vim.lsp.enable("ruff")
  end,
}
