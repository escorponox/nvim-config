local M = {}

-- Base URL for opencode API
local base_url = "http://localhost:4096"

-- Helper function to make GET requests
---@diagnostic disable-next-line: unused-local, unused-function
local function api_get(endpoint)
  local cmd = string.format("curl -s '%s%s'", base_url, endpoint)
  local result = vim.fn.system(cmd)
  return result
end

-- Helper function to make POST requests with JSON data
local function api_post(endpoint, data)
  local json_data = vim.fn.json_encode(data)
  local cmd =
    string.format("curl -s -X POST -H 'Content-Type: application/json' -d '%s' '%s%s'", json_data, base_url, endpoint)
  local result = vim.fn.system(cmd)
  return result
end

-- Send a message to a session
--- @class execute_command
--- @field command "/explain or /basics"
--- @field args "file and optional selection and user input"
local function execute_command(command, args)
  api_post("/tui/execute-command", {
    command = "session_new",
  })
  api_post("/tui/append-prompt", {
    text = command .. " " .. args,
  })
  api_post("/tui/submit-prompt")
end

--- @class explain
--- @field mode "dude or tutor"
function M.explain(mode)
  local current_project = api_get("/project/current")
  if current_project == "" then
    require("notify")("OpenCode: No current project found.")
    return
  end

  local current_working_directory = vim.fn.getcwd()

  local current_project_data = vim.fn.json_decode(current_project)
  if current_project_data["worktree"] ~= current_working_directory then
    require("notify")("OpenCode: Current project does not match working directory.")
    return
  end

  local file = "@" .. vim.fn.fnamemodify(vim.fn.expand("%"), ":.")
  local cursor_position = vim.fn.getpos(".")

  Snacks.input.input({
    prompt = mode,
  }, function(user_input)
    if user_input == nil then
      return
    end
    local text = file .. " line: " .. cursor_position[2] .. " col: " .. cursor_position[3]
    if user_input ~= "" then
      text = text .. " User input: " .. user_input
    end
    -- print("Executing command with text:", text)
    if mode == "dude" then
      execute_command("/explain", text)
    else
      execute_command("/basics", text)
    end
  end)
end

vim.keymap.set("n", ",ee", function()
  M.explain("dude")
end, { silent = true, desc = "opencode dude" })

vim.keymap.set("n", ",et", function()
  M.explain("tutor")
end, { silent = true, desc = "opencode tutor" })

return M
