local util = require("user.util")
local CONFIG_PATH = ".vscode/settings.json"
local LAUNCH_PATH = ".vscode/launch.json"

local function remove_comments_from_json(json_string)
  json_string = json_string:gsub("//.-\n", "")
  json_string = json_string:gsub("[^*]/%*.-%*/", "")

  return json_string
end

local function resolve_workspace_path(json_string)
  return json_string:gsub("${workspaceFolder}", vim.fn.getcwd())
end

local function parse_config()
  local file = io.open(CONFIG_PATH, "r")
  if file == nil then
    return nil
  end
  local json_string = file:read("*all")
  file:close()

  json_string = remove_comments_from_json(json_string)
  json_string = resolve_workspace_path(json_string)
  local config = vim.json.decode(json_string)
  return config
end

local config = parse_config() or {}

local function launch_file_exists()
  local file = io.open(LAUNCH_PATH)
  if not file then
    return false
  end
  io.close(file)
  return true
end

return {
  black_args = config["python.formatting.blackArgs"],
  pylint_args = config["python.linting.pylintArgs"],
  mypy_args = config["python.linting.mypyArgs"],
  eslint_config_path = util.table_lookup(config, "eslint.options", "configFile"),
  launch_file_exists = launch_file_exists
}

