local f = require("plugins.common.formatters")

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  init = function()
    -- add border to hover
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.diagnostic.config({
      float = { border = "rounded" },
    })

    -- Global mappings
    vim.keymap.set("n", "<C-k>", vim.diagnostic.goto_prev)
    vim.keymap.set("n", "<C-j>", vim.diagnostic.goto_next)
    vim.keymap.set("n", "<C-h>", function()
      vim.lsp.inlay_hint(0, nil)
    end, { desc = "Toggle Inlay Hints" })
    local lspconfig = require("lspconfig")

    local formatGroup = vim.api.nvim_create_augroup("LspFormatting", {})
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        local bufopts = { noremap = true, silent = true, buffer = ev.buf }
        vim.keymap.set("n", "gr", vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "ga", vim.lsp.buf.code_action, bufopts)

        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)

        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        if client ~= nil and client.name == "gopls" then
          if not client.server_capabilities.semanticTokensProvider then
            local semantic = client.config.capabilities.textDocument.semanticTokens
            if semantic ~= nil then
              client.server_capabilities.semanticTokensProvider = {
                full = true,
                legend = {
                  tokenTypes = semantic.tokenTypes,
                  tokenModifiers = semantic.tokenModifiers,
                },
                range = true,
              }
            end
          end
        end

        local should_format = f.should_format_with_lsp(vim.bo[ev.buf].filetype)
        if client ~= nil and should_format and client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = formatGroup, buffer = ev.buf })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = formatGroup,
            buffer = ev.buf,
            callback = function(args)
              vim.lsp.buf.format({ bufnr = args.buf, async = false })
            end,
          })
        end
      end,
    })

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = false

    -- Golang
    lspconfig.gopls.setup({
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

    -- terraform
    lspconfig.terraformls.setup({ capabilities = capabilities })

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
  end,
}
