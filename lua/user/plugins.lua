local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

return packer.startup(function(use)
  use({ "wbthomason/packer.nvim", lock = true }) -- Have packer manage itself
  use({ "nvim-lua/popup.nvim", lock = true }) -- An implementation of the Popup API from vim in Neovim
  use({ "nvim-lua/plenary.nvim", lock = true }) -- Useful lua functions used ny lots of plugins

  -- LSP
  use({ "williamboman/mason.nvim", lock = true }) -- simple language server installer
  use({ "neovim/nvim-lspconfig", lock = true }) -- configures language server
  use({ "williamboman/mason-lspconfig.nvim", lock = true }) -- bridge between nvim-lspconfig and mason

  -- Completion
  use({ "hrsh7th/nvim-cmp", lock = true }) -- The completion plugin
  use({ "hrsh7th/cmp-buffer", lock = true }) -- buffer completions
  use({ "hrsh7th/cmp-path", lock = true }) -- path completions
  use({ "hrsh7th/cmp-cmdline", lock = true }) -- cmdline completions
  use({ "hrsh7th/cmp-nvim-lsp", lock = true }) -- lsp completions
  use({ "saadparwaiz1/cmp_luasnip", lock = true }) -- snippet completions
  use({ "windwp/nvim-autopairs", lock = true }) -- Autopairs, integrates with both cmp and treesitter

  -- Null LS
  use({
    "jose-elias-alvarez/null-ls.nvim",
    lock = true,
    requires = { "nvim-lua/plenary.nvim" },
  })
  -- Debugging
  use({ "mfussenegger/nvim-dap", tag = "0.3.0" })
  use({ "rcarriga/nvim-dap-ui", tag = "v2.6.0" })

  -- Telescope
  use({ "nvim-telescope/telescope.nvim", lock = true })

  -- Treesitter
  use({ "nvim-treesitter/nvim-treesitter", lock = true })

  -- Comments
  use({ "numToStr/Comment.nvim", lock = true })
  use({ "JoosepAlviste/nvim-ts-context-commentstring", lock = true })

  -- Indent indicator
  use({ "lukas-reineke/indent-blankline.nvim", lock = true })

  -- Git
  use({ "tpope/vim-fugitive", lock = true })
  use({ "lewis6991/gitsigns.nvim", lock = true })

  -- File tree sidebar
  use({
    "nvim-tree/nvim-tree.lua",
    lock = true,
    requires = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
  })

  -- Tabs
  use({ "romgrk/barbar.nvim", lock = true, wants = "nvim-web-devicons" })

  -- Snippets
  use({ "L3MON4D3/LuaSnip", lock = true }) --snippet engine
  use({ "rafamadriz/friendly-snippets", lock = true }) -- a bunch of snippets to use

  -- Status line
  use({ "nvim-lualine/lualine.nvim", lock = true })

  -- Color schemes
  use({ "ellisonleao/gruvbox.nvim", lock = true })
  use({ "lunarvim/darkplus.nvim", lock = true })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
