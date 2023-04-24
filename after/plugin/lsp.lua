local lsp = require("lsp-zero").preset({
	name = "recommended",
	set_lsp_keymaps = true,
	manage_nvim_cmp = true,
	suggest_lsp_servers = false,
})

lsp.ensure_installed({
	"tsserver",
	"rust_analyzer",
	"eslint",
	"zls",
	"gopls",
	"lua_ls",
	"html",
	"tailwindcss",
	"cssls",
	"denols",
	"emmet_ls",
	"jsonls",
})

-- Fix Undefined global 'vim'
lsp.configure("lua-language-server", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

-- initialize rust_analyzer with rust-tools
-- see :help lsp-zero.build_options()
local rust_lsp = lsp.build_options("rust_analyzer", {
	single_file_support = true,
	on_attach = function(client, bufnr)
		print("hello rust-tools")
	end,
})

require("rust-tools").setup({ server = rust_lsp })
-- (Optional) Configure lua language server for neovim
require("lspconfig").eslint.setup({})

lsp.setup()

local cmp = require("cmp")

require("luasnip.loaders.from_vscode").lazy_load()

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lsp.setup_nvim_cmp({
	formatting = {
		-- changing the order of fields so the icon is the first
		fields = { "menu", "abbr", "kind" },

		-- here is where the change happens
		format = function(entry, item)
			local menu_icon = {
				nvim_lsp = "λ",
				luasnip = "⋗",
				buffer = "Ω",
				path = "🖫",
				nvim_lua = "Π",
			}

			item.menu = menu_icon[entry.source.name]
			return item
		end,
	},
	mapping = cmp_mappings,
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "buffer", keyword_length = 3 },
		{ name = "luasnip", keyword_length = 2 },
		{ name = "crates" },
	},
})

lsp.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	},
})

lsp.nvim_workspace()

local cmp_action = require("lsp-zero").cmp_action()

cmp.setup({
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "buffer", keyword_length = 3 },
		{ name = "luasnip", keyword_length = 2 },
		{ name = "crates" },
	},
	mapping = {
		["<C-f>"] = cmp_action.luasnip_jump_forward(),
		["<C-b>"] = cmp_action.luasnip_jump_backward(),
	},
})

local null_ls = require("null-ls")
local null_opts = lsp.build_options("null-ls", {})

vim.diagnostic.config({
	virtual_text = true,
	underline = false,
})
