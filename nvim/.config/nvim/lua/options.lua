vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"
vim.opt.cursorcolumn = false

vim.api.nvim_set_hl(0, "LineNr", {
	fg = "#222222",
})

vim.api.nvim_set_hl(0, "LineNrAbove", {
	fg = "#222222",
})

vim.api.nvim_set_hl(0, "LineNrBelow", {
	fg = "#222222",
})

vim.api.nvim_set_hl(0, "CursorLine", {
	bg = "#222222",
})
