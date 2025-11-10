return {
  "olimorris/codecompanion.nvim",
  enabled = true,
  keys = {
    { "<leader>cc", ":CodeCompanionActions<CR>", desc = "CodeCompanionActions" },
  },
  opts = {
    strategies = {
      chat = {
        adapter = "openrouter",
        variables = {
          ["buffer"] = {
            opts = {
              default_params = "watch", -- 'pin' or 'watch'
            },
          },
        },
      },
      inline = {
        adapter = "copilot",
      },
      cmd = {
        adapter = "copilot",
      },
    },
    adapters = {
      http = {
        openrouter = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "https://openrouter.ai/api",
              api_key = "OPENROUTER_API_KEY",
              chat_url = "/v1/chat/completions",
            },
            schema = {
              model = {
                default = "anthropic/claude-sonnet-4.5",
              },
              reasoning = {
                enabled = true,
                max_tokens = 16384,
              },
            },
          })
        end,
      },
    },
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_tools = true,
          show_server_tools_in_chat = true,
          add_mcp_prefix_to_tool_names = false,
          show_result_in_chat = true,
          show_model_choices = true,
          format_tool = nil,
          make_vars = true,
          make_slash_commands = true,
        },
      },
    },
    prompt_library = {
      ["React"] = {
        strategy = "chat",
        description = "Write React code.",
        opts = {
          index = 1,
        },
        prompts = {
          {
            role = "system",
            content = [[You carefully provide accurate, factual, thoughtful, nuanced answers, and are brilliant at reasoning. If you think there might not be a correct answer, you say so. Always spend a few sentences explaining background context, assumptions, and step-by-step thinking BEFORE you try to answer a question. Don't be verbose in your answers, but do provide details and examples where it might help the explanation.
                You are an expert software engineer for the JavaScript, TypeScript, HTML, CSS, GraphQL languages, React framework and ApolloClient.
                You do not use useMemo or useCallback unless absolutely necessary.
                You follow best practices in the docs folder of the current project.
                Access design system components in ~/repo/LECDesignSystem to transform current component in design components. To do that, first of all, use the name of the figma component to find a design system component that matches with it. Make a list of not matching components.
                If you find a Tab group or similar in figma use a layout and design system Tabs component.
                If you find a figma component which name contains "Input" search the components in design system in Input folder before create a customized component.
                Before customize components, analyze current project decisions.
                Ensure all the tools in the user propmts are triggered in your response.
                ]],
          },
          {
            role = "user",
            content = [[You use @{context7} MCP to look for React documentation and best practices.
You use @{apollo__ApolloDocsSearch} to read Apollo Client documentation.
Use @{full_stack_dev}.
You use @{figma_dev_mode_mcp} to extract design information from Figma design files here: 
            ]],
            opts = {
              auto_submit = false,
            },
          },
        },
      },
      ["React testing"] = {
        strategy = "workflow",
        description = "Write React testing code.",
        opts = {
          index = 2,
        },
        prompts = {
          {
            {
              role = "system",
              content = [[You are an expert software engineer for the JavaScript, TypeScript, HTML, CSS and GraphQL languages, React framework and ApolloClient.
            You create and edit a test file next to with the .test.tsx extension if it does not exist.
            You write tests using Vitest and React Testing Library.
            You mock modules using Vitest mocking capabilities.
            You do not touch app code in any way.
            You do not introduce TypeScript or Biome errors.
            ## Common Testing Patterns
            
            1. **Happy Path Testing**
               - Test the main user flow
               - Verify expected behavior with valid inputs
               - Confirm successful operation completion
            
            2. **Error Path Testing**
               - Test with invalid inputs
               - Verify error messages and status codes
               - Check error recovery mechanisms
            
            3. **Boundary Testing**
               - Test at the limits of acceptable values
               - Check behavior just inside and outside boundaries
               - Verify handling of edge cases

           ]],
            },
            {
              role = "user",
              content = [[Use @{full_stack_dev} to write tests for the code in #{buffer} in a test.ts(x) file next to it. If a test file already exists, analyze it and add missing tests following best practices. Ensure all new and existing tests pass without introducing TypeScript or Biome errors.

              ]],
              opts = {
                auto_submit = false,
              },
            },
          },
          {
            {
              role = "user",
              opts = {
                auto_submit = true,
                visible = false,
              },
              content = [[
                 ### Instructions

                 Your instructions here
                 
                 ### Steps to Follow
                 
                 You are required to write code following the instructions provided above and test the correctness by running the designated test suite. Follow these steps exactly:

                 1. You use @{cmd_runner} to run `npx vitest run <new_test_file_placeholder> --reporter=verbose --no-coverage` to run only the tests in the modified file.
                 2. You use @{cmd_runner} to run `npm run test:local` to make sure all tests pass.
                 3. You use @{cmd_runner} to run `npm run type-check` to make sure there are no TypeScript errors.
                 4. You use @{cmd_runner} to run `npm run biome:check` to make sure there are no Biome errors.
                 5. If tests do not pass or there are TypeScript or Biome errors, you analyze the errors and use @{full_stack_dev} to modify the test code to fix the issues.
                 6. Make sure you trigger both tools in the same response.
                 7. Repeat steps 1-5 up to three times until all tests pass and there are no TypeScript or Biome errors. Ensure no deviation from these steps.
                 8. If all the test pass and no errors, show suggestions on how to improve the app code testability. Otherwise, report issues preventing completion and ask user for help.

              ]],
            },
            {
              role = "user",
              content = "",
              opts = {
                auto_submit = true,
                visible = false,
              },
            },
          },
        },
      },
      ["JSDoc"] = {
        strategy = "chat",
        description = "Write JSDocs code.",
        opts = {
          index = 3,
        },
        prompts = {
          {
            role = "system",
            content = [[You carefully provide accurate, factual, thoughtful, nuanced answers, and are brilliant at reasoning.  Always spend a few sentences explaining background context, assumptions, and step-by-step thinking BEFORE you try to answer a question. Don't be verbose in your answers, but do provide details and examples where it might help the explanation.
                You are an expert technical writer software engineer for the JavaScript, TypeScript, HTML, CSS, GraphQL languages, React framework and ApolloClient.
                You write clear and concise JSDoc comments for functions, classes, and complex code sections in the project.
                You describe parameters, return types, and any exceptions that might be thrown.
                You analyze project files and code usages to provide examples.
                ]],
            opts = {
              auto_submit = true,
              visible = true,
            },
          },
          {
            role = "user",
            content = "Use @{full_stack_dev} to analyze code in #{buffer} and add JSDoc comments where missing or improve existing ones. Find code usages in the project to provide relevant examples.",
            opts = {
              auto_submit = false,
            },
          },
        },
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "ravitemer/mcphub.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
      config = function()
        require("mcphub").setup({
          global_env = {
            REPOSITORY_PATH = vim.fn.getcwd(),
          },
          extensions = {
            codecompanion = {
              enabled = true,
              convert_tools_to_functions = true,
              convert_resources_to_functions = true,
              add_mcp_prefix = true,
            },
          },
        })
      end,
    },
    {
      "echasnovski/mini.diff",
      config = function()
        local diff = require("mini.diff")
        diff.setup({
          source = diff.gen_source.none(),
        })
      end,
    },
  },
}
