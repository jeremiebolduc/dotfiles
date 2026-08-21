vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
	callback = function()
		vim.opt.relativenumber = false
	end,
})
vim.api.nvim_create_autocmd({ "InsertLeave", "CmdlineLeave" }, {
	callback = function()
		vim.opt.relativenumber = true
	end,
})
