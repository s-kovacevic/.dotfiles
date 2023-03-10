local dap = require("dap")
local dap_vscode = require("dap.ext.vscode")
local vscode = require("user.vscode")


-- DAP style
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = ".>", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "", linehl = "", numhl = "" })

-- Adapters
dap.adapters.python = function(cb, config)
  if config.request == "attach" then
    cb({
      type = "server",
      port = config.port,
      host = config.host,
      options = {
        source_filetype = "python",
      }
    })
  else
    cb({
      type = "executable";
      command = os.getenv("VIRTUAL_ENV") .. "/bin/python";
      args = { "-m", "debugpy.adapter" };
      options = {
        source_filetype = "python",
      }
    })
  end
end

dap.adapters.go = {
  type = 'server',
  port = '${port}',
  executable = {
    command = 'dlv',
    args = {'dap', '-l', '127.0.0.1:${port}'},
  }
}


if vscode.launch_file_exists() then
  dap_vscode.load_launchjs()
else
  dap.configurations.python = {
    {
      type = "python"; -- the type here established the link to the adapter definition: `dap.adapters.python`
      request = "launch";
      name = "Launch file";
      program = "${file}"; -- This configuration will launch the current file if used.
    },
  }
  -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
  dap.configurations.go = {
    {
      type = "delve",
      name = "Debug",
      request = "launch",
      program = "${file}"
    },
    {
      type = "delve",
      name = "Debug test", -- configuration for debugging test files
      request = "launch",
      mode = "test",
      program = "${file}"
    },
    -- works with go.mod packages and sub packages 
    {
      type = "delve",
      name = "Debug test (go.mod)",
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}"
    }
  }
end


require("nvim-dap-virtual-text").setup({
  enabled = true, -- enable this plugin (the default)
  enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
  highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
  highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
  show_stop_reason = true, -- show stop reason when stopped for exceptions
  commented = false, -- prefix virtual text with comment string
  only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
  all_references = false, -- show virtual text on all all references of the variable (not only definitions)
  filter_references_pattern = '<module', -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
  -- experimental features:
  virt_text_pos = 'eol', -- position of virtual text, see `:h nvim_buf_set_extmark()`
  all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
  virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
  virt_text_win_col = nil -- position the virtual text at a fixed window column (starting from the first text column) ,
  -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
})

-- After debugging is finished, remove existing virtual text
dap.listeners.before.event_terminated["clear_virtual_text"] = function()
  require("nvim-dap-virtual-text").refresh()
end
dap.listeners.before.event_exited["clear_virtual_text"] = function()
  require("nvim-dap-virtual-text").refresh()
end
