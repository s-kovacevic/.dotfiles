-- TODO:
-- Add pytest integration
-- Check https://github.com/puremourning/vimspector for debugging
-- Add bandit linter
-- Check https://github.com/lukas-reineke/indent-blankline.nvim for indentation indicators
-- Check tpope/vim-fugitive for git things
-- Check https://github.com/famiu/bufdelete.nvim to stop panels from jumping when closing buffers
-- Check https://github.com/folke/which-key.nvim for help popups
-- Check https://github.com/goolord/alpha-nvim for startup theme
-- Lock plugin versions, fix how dependencies are managed ( wants = )
require("user.options")
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

