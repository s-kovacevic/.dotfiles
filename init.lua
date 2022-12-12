-- TODO:
-- Add pytest integration
-- Check https://github.com/puremourning/vimspector for debugging
-- Add bandit linter
-- Check https://github.com/goolord/alpha-nvim for startup theme
-- Fix how dependencies are managed ( wants = )
require("user.options")
require("user.which-key")
require("user.keymaps")
require("user.plugins")
require("user.colorscheme")
require("user.completion")
require("user.lsp")
require("user.telescope")
require("user.treesitter")
require("user.autopairs")
require("user.comment")
require("user.gitsigns")
require("user.nvimtree")
require("user.barbar")
require("user.null-ls")
require("user.lualine")
require("user.indent-blankline")
require("user.debugging")

