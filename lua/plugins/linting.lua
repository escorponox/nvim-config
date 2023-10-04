return {
  "mfussenegger/nvim-lint",
  event = "BufReadPost",
  opts = {
    -- Event to trigger linters
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    linters_by_ft = {
      ["javascript"] = { { "eslint" }, { ignore_errors = true } },
      ["javascriptreact"] = { { "eslint" }, { ignore_errors = true } },
      ["typescript"] = { { "eslint" }, { ignore_errors = true } },
      ["typescriptreact"] = { { "eslint" }, { ignore_errors = true } },
    },
    -- LazyVim extension to easily override linter options
    -- or add custom linters.
    ---@type table<string,table>
    linters = {
      -- -- Example of using selene only when a selene.toml file is present
      -- selene = {
      --   -- `condition` is another LazyVim extension that allows you to
      --   -- dynamically enable/disable linters based on the context.
      --   condition = function(ctx)
      --     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
      --   end,
      -- },
    },
  },
  config = function(_, opts)
    local M = {}

    local lint = require("lint")
    for name, linter in pairs(opts.linters) do
      lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name] or {}, linter)
    end
    lint.linters_by_ft = opts.linters_by_ft

    function M.debounce(ms, fn)
      local timer = vim.loop.new_timer()
      return function(...)
        local argv = { ... }
        timer:start(ms, 0, function()
          timer:stop()
          vim.schedule_wrap(fn)(unpack(argv))
        end)
      end
    end

    function M.lint()
      local lint_module = require("lint")
      local config = lint_module.linters_by_ft[vim.bo.filetype] or {}
      local linter_name, config_opts = config[1] or {}, config[2] or {}
      local ctx = { filename = vim.api.nvim_buf_get_name(0) }
      ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
      linter_name = vim.tbl_filter(function(name)
        local linter = lint_module.linters[name]
        return linter and not (linter.condition and not linter.condition(ctx))
      end, linter_name)

      if #linter_name > 0 then
        lint_module.try_lint(linter_name, config_opts)
      end
    end

    vim.api.nvim_create_autocmd(opts.events, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = M.debounce(100, M.lint),
    })
  end,
}
