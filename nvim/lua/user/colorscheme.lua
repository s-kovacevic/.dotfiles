local colorscheme = "tokyonight"

if colorscheme ~= "tokyonight" then
  local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
  if not ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
  end
  return
end


local ok, tokyonight = pcall(require, "tokyonight")
if ok then
  local util = require("tokyonight.util")
  tokyonight.setup({
    style = "moon",
    on_colors = function(colors)
      vim.inspect(colors)
      colors.gitSigns = {
        add = colors.green,
        change = colors.cyan,
        delete = colors.red
      }
    end,
    on_highlights = function(hl, _)
      hl.LineNr = {
        fg = util.lighten(hl.LineNr.fg, 0.8)
      }
      hl.Visual = {
        bg = util.darken("#2D4F67", 0.6)
      }
    end
  })
  vim.cmd("colorscheme " .. colorscheme)
else
  vim.notify("tokyonight colorscheme not installed!")
  return
end
