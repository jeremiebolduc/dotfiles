return {
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		config = function()
			require("tiny-inline-diagnostic").setup({
				preset = "modern",
				options = {
					multilines = {
						enabled = true,
						always_show = true,
						severity = { vim.diagnostic.severity.ERROR },
					},
				},
			})
			vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
			-- Keymaps
			vim.keymap.set("n", "<leader>dt", "<cmd>TinyInlineDiag toggle<cr>", { desc = "Toggle diagnostics" })
			vim.keymap.set("n", "<leader>dr", "<cmd>TinyInlineDiag reset<cr>", { desc = "Reset diagnostic options" })
		end,
	},
}
