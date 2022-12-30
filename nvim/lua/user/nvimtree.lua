local nvim_tree = require("nvim-tree")
local nvim_tree_api = require("nvim-tree.api")

-- Callbacks that close sidebar after picking file
local function edit_and_close(node)
  nvim_tree_api.node.open.edit()
  if node.type == "file" then
    nvim_tree_api.tree.close()
  end
end

local function vsplit_and_close(node)
  nvim_tree_api.node.open.vertical()
  if node.type == "file" then
    nvim_tree_api.tree.close()
  end
end

nvim_tree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  ignore_ft_on_setup = {
    "startify",
    "dashboard",
    "alpha",
  },
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = false,
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = false,
    ignore_list = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    hide_root_folder = false,
    side = "left",
    mappings = {
      custom_only = false,
      list = {
        { key = { "l", "<CR>" }, action = "edit_and_close", action_cb = edit_and_close },
        { key = "O", action = "edit" },
        { key = "h", action = "close_node" },
        { key = "v", action = "vsplit_and_close", action_cb = vsplit_and_close },
      },
    },
    number = false,
    relativenumber = false,
  },
  filters = {
    dotfiles = true,
  },
  renderer = {
    highlight_git = true,
    root_folder_modifier = ":t",
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          deleted = "",
          untracked = "U",
          ignored = "◌",
        },
        folder = {
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
        },
      }
    }
  }
})
