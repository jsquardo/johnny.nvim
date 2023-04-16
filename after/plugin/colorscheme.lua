require("catppuccin").setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	background = { -- :h background
		dark = "mocha",
	},
	transparent_background = false,
	show_end_of_buffer = false, -- show the '~' characters after the end of buffers
	term_colors = true,
	no_italic = true, -- Force no italic
	no_bold = true, -- Force no bold
	styles = {
		comments = { "italic" },
		conditionals = {},
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},
	color_overrides = {},
	integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		telescope = true,
		notify = true,
		mini = false,
		native_lsp = {
			enabled = true,
			underlines = {
				errors = {},
				hints = {},
				warnings = {},
				information = {},
			},
		},
		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	},
	highlight_overrides = {
		all = function(colors)
			return {
				underlines = {},
			}
		end,
	},
})

-- setup must be called before loading
vim.cmd.colorscheme("catppuccin")
