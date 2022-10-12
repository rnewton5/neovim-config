local fn = vim.fn

local ensure_packer = function()
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

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
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "kyazdani42/nvim-web-devicons" -- File icons
  use "moll/vim-bbye" -- Better closing of buffers
  use "MunifTanjim/nui.nvim"

  -- Source per-project config file (.exrc.lua)
  use "MunifTanjim/exrc.nvim"

  -- Dashboard
  use "goolord/alpha-nvim"

  -- Statusline
  use "nvim-lualine/lualine.nvim"

  -- File explorer
  use "kyazdani42/nvim-tree.lua"

  -- Bufferline
  use "akinsho/bufferline.nvim"

  -- Terminal
  use "akinsho/toggleterm.nvim"

  -- Guides on indented lines
  use "lukas-reineke/indent-blankline.nvim"

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
  use "jose-elias-alvarez/null-ls.nvim"
  use "simrat39/symbols-outline.nvim"
  use "simrat39/rust-tools.nvim"

  -- Debugging
  use "mfussenegger/nvim-dap"
  use "theHamsta/nvim-dap-virtual-text"
  use "rcarriga/nvim-dap-ui"
  use "nvim-telescope/telescope-dap.nvim"
  use "jbyuki/one-small-step-for-vimkind"
  use "Weissle/persistent-breakpoints.nvim"

  -- Snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-media-files.nvim"

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "p00f/nvim-ts-rainbow"

  -- Auto close brackets
  use "windwp/nvim-autopairs"

  -- Git integration
  use "lewis6991/gitsigns.nvim"

  -- Highlight
  use "RRethy/vim-illuminate"

  -- Scrollbar with diagnostics
  use "petertriho/nvim-scrollbar"

  -- Colorschemes
  use "lunarvim/colorschemes"
  use "folke/tokyonight.nvim"
  use "morhetz/gruvbox"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)

-- configure plugins
require("plugins.configs")
