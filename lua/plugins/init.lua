local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost ~/.config/nvim/lua/plugins/init.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
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

-- Install your plugins here
packer.startup(function(use)
  -- have packer manager itself
	use "wbthomason/packer.nvim"

	use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins
	use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "lewis6991/impatient.nvim" -- speeds up startup time

  -- Manages LSP servers, debug adapters, linters, and formatters
  use "williamboman/mason.nvim"

  -- cmp with plugins
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp" -- LSP completions
  use "hrsh7th/nvim-cmp" -- The completion plugin

  -- LSP stuff
  use "williamboman/mason-lspconfig.nvim"
  use "neovim/nvim-lspconfig"

  -- Snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use 'nvim-telescope/telescope-media-files.nvim'

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use "p00f/nvim-ts-rainbow"
  use "nvim-treesitter/playground"

  -- Colorschemes
  use "lunarvim/colorschemes"
  use "folke/tokyonight.nvim"
  use "morhetz/gruvbox"

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)

-- configure plugins
require "plugins.configs.mason"
require "plugins.configs.cmp"
require "plugins.configs.lsp"
require "plugins.configs.telescope"
require "plugins.configs.treesitter"

