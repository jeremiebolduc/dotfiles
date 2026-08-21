vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.showmode = false

vim.api.nvim_set_hl(0, "LineNr", {
	fg = "#999999",
})

vim.api.nvim_set_hl(0, "LineNrAbove", {
	fg = "#999999",
})

vim.api.nvim_set_hl(0, "LineNrBelow", {
	fg = "#999999",
})

