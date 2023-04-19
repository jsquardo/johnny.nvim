require("FTerm").setup({
	--cmd = "chsh -s /bin/zsh",
})

vim.keymap.set("n", "<A-`>", '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set("t", "<A-`>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
