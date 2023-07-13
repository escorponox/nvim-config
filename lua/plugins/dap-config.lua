return {
  'mfussenegger/nvim-dap',
  dependencies = {
    {
      'rcarriga/nvim-dap-ui',
      keys = { { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" } },
      opts = {
        icons = {
          expanded = "",
          collapsed = "",
        },
        mappings = {
          expand = "o",
        },
        expand_lines = false,
        layouts = {
          {
            elements = {
              { id = "scopes", size = 1 },
            },
            position = "right",
            size = 80
          },
          {
            elements = {
              { id = "stacks",  size = 0.5 },
              { id = "watches", size = 0.5 }
            },
            position = "bottom",
            size = 20
          },
          -- {
          --   elements = {
          --     { id = "scopes",      size = 0.25 },
          --     { id = "breakpoints", size = 0.25 },
          --     { id = "stacks",      size = 0.25 },
          --     { id = "watches",     size = 0.25 }
          --   },
          --   position = "right",
          --   size = 80
          -- },
          -- {
          --   elements = {
          --     { id = "repl",    size = 0.5 },
          --     { id = "console", size = 0.5 }
          --   },
          --   position = "bottom",
          --   size = 20
          -- },
        }
      },
      config = function(_, opts)
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close({})
        end
      end,
    },
    {
      "theHamsta/nvim-dap-virtual-text",
      enable = true,
      opts = {},
    },
    {
      'leoluz/nvim-dap-go',
      keys = {
        { "<leader>dt", function() require("dap-go").debug_test() end, desc = "Debug test Go" },
        { "<leader>dl", function() require("dap-go").debug_test() end, desc = "Debug last test Go" }
      },
      opts = {},
      config = function()
        require("dap-go").setup()
      end
    },
  },
  keys = {
    {
      "<leader>dB",
      function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
      desc = "Breakpoint Condition"
    },
    {
      "<leader>db",
      function() require("dap").toggle_breakpoint() end,
      desc = "Toggle Breakpoint"
    },
    {
      "<leader>dc",
      function() require("dap").continue() end,
      desc = "Continue"
    },
    {
      "<leader>dC",
      function() require("dap").run_to_cursor() end,
      desc = "Run to Cursor"
    },
    {
      "<leader>di",
      function() require("dap").step_into() end,
      desc = "Step Into"
    },
    {
      "<leader>dO",
      function() require("dap").step_out() end,
      desc = "Step Out"
    },
    {
      "<leader>do",
      function() require("dap").step_over() end,
      desc = "Step Over"
    },
    {
      "<leader>dr",
      function() require("dap").repl.toggle() end,
      desc = "Toggle REPL"
    },
    {
      "<leader>ds",
      function() require("dap").session() end,
      desc = "Session"
    },
    {
      "<leader>dT",
      function() require("dap").terminate() end,
      desc = "Terminate"
    },
    {
      "<leader>dw",
      function() require("dap.ui.widgets").hover() end,
      desc = "Widgets"
    },
  },
  config = function()
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    vim.fn.sign_define('DapStopped',
      { text = '>>', texthl = 'DiagnosticWarn', linehl = 'DapStoppedLine', numhl = 'DabStoppedLine' })
    vim.fn.sign_define('DapBreakpoint', { text = 'B ', texthl = 'DiagnosticInfo', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition', { text = 'C ', texthl = 'DiagnosticInfo', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = 'E ', texthl = 'DiagnosticError', linehl = '', numhl = '' })
    vim.fn.sign_define('LogPoint', { text = '.>', texthl = 'DiagnosticInfo', linehl = '', numhl = '' })
  end
}
