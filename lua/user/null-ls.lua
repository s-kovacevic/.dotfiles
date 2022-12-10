local ok, null_ls = pcall(require, "null-ls")
if not ok then
  print "null-ls not installed"
  return
end

local workspace_root = vim.fn.getcwd()

null_ls.setup({
  debug = true,
  sources = {
    null_ls.builtins.formatting.black.with({
      extra_args = { "--line-length", "119", "--target-version", "py310" }
    }),
    null_ls.builtins.diagnostics.pylint.with({
      extra_args = { "--load-plugins=pylint_django", "--init-hook",
        "import sys;sys.path.append('" .. workspace_root .. "/backend')", "--rcfile",
        workspace_root .. "/backend/.pylintrc" }
    }),
    null_ls.builtins.diagnostics.mypy.with({
      extra_args = { "--config-file", "backend/mypy.ini" },
      cwd = function (_) return vim.fn.getcwd() end
    }),
    null_ls.builtins.diagnostics.eslint.with({
      extra_args = { "-c", workspace_root .. "/frontend/.eslintrc" }
    }),
    null_ls.builtins.diagnostics.flake8.with({
      extra_args = { "--config", workspace_root .. "/backend/.flake8" }
    })
  },
})
