local fn = vim.fn

-- Only required if you have packer configured as `opt`
vim.cmd.packadd("packer.nvim")

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
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
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

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	-- Colorscheme
	use({ "catppuccin/nvim", as = "catppuccin" })
	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/playground")
	use("nvim-treesitter/nvim-treesitter-context")
	-- LSP and Mason
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ -- Optional
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
		-- Rust
		use("simrat39/rust-tools.nvim"),
		use({
			"saecki/crates.nvim",
			tag = "v0.3.0",
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				require("crates").setup()
			end,
		}),

		-- Null-ls Autoformatting and some Diagnostics
		use({
			"jose-elias-alvarez/null-ls.nvim",
			config = function()
				require("null-ls").setup()
			end,
			requires = { "nvim-lua/plenary.nvim" },
		}),

		-- Formatting
		use({ "mhartington/formatter.nvim" }),

		-- Autopairs
		use({
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup({})
			end,
		}),

		-- TS-AutoTag
		use("windwp/nvim-ts-autotag"),

		use("ThePrimeagen/harpoon"),

		-- Golang
		use("ray-x/go.nvim"),
	})
end)