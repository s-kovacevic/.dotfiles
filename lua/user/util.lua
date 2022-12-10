local M = {}

-- Detects if command is present on the path and callable
M.command_exists = function (cmd)
  local cmd_type = io.popen("type -p " .. cmd .. " 2>/dev/null")
  if cmd_type == nil then
    return false
  end
  local cmd_exists = cmd_type:read("*a")
  cmd_type:close()
  return cmd_exists ~= ""
end

-- Get nested keys without checking each null, equivalent of tbl.a?.b?.c?
M.table_lookup = function (t, ...)
    for _, k in ipairs{...} do
        t = t[k]
        if not t then
            return nil
        end
    end
    return t
end

return M
