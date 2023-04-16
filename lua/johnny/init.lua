require("johnny.remap")
require("johnny.set")
require("johnny.packer")

local augroup = vim.api.nvim_create_augroup
local JohnnyGroup = augroup("JohnnyGroup", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
	require("plenary.reload").reload_module(name)
end

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Underline
-- Put this at the bottom of your init.lua
local highlights = {
	DiagnosticUnnecessary = { bg = "NONE" },
	DiagnosticUnderlineError = { underline = false },
	DiagnosticUnderlineInfo = { underline = false },
	DiagnosticUnderlineWarn = { underline = false },
	DiagnosticUnderlineHint = { underline = false },
}

for group, value in pairs(highlights) do
	vim.api.nvim_set_hl(0, group, value)
end
