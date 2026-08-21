local lsp = require("lsp")

return {
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
		},
		opts = {
			ensure_installed = lsp.servers,
			-- Restrict automatic activation to the servers this config owns.
			automatic_enable = lsp.servers,
		},
		config = function(_, opts)
			lsp.setup(opts)
		end,
	},
}
