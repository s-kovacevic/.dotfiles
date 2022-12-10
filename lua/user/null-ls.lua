local ok, null_ls = pcall(require, "null-ls")
if not ok then
  print "null-ls not installed"
  return
end
local vscode = require("user.vscode")
local util = require("user.util")

local sources = {}
if util.command_exists("black") then
  table.insert(
    sources,
    null_ls.builtins.formatting.black.with({
      extra_args = vscode.black_args
    })
  )
end

if util.command_exists("pylint") then
  table.insert(
    sources,
    null_ls.builtins.diagnostics.pylint.with({
      extra_args = vscode.pylint_args
    })
  )
end

if util.command_exists("mypy") then
  table.insert(
    sources,
    null_ls.builtins.diagnostics.mypy.with({
      extra_args = vscode.mypy_args,
      cwd = function(_) return vim.fn.getcwd() end
    })
  )
end

if util.command_exists("flake8") then
  table.insert(
    sources,
    null_ls.builtins.diagnostics.flake8
  )
end

if util.command_exists("eslint") then
  table.insert(
    sources,
    null_ls.builtins.diagnostics.eslint.with({
      extra_args = vscode.eslint_config_path and { "-c", vscode.eslint_config_path } or {}
    })
  )
end

null_ls.setup({ sources = sources })
