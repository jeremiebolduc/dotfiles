return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "goimports", "gofmt" },
			rust = { "rustfmt" },
			javascript = { "prettierd", "prettier" },
			typescript = { "prettierd", "prettier" },
			json = { "prettierd", "prettier" },
			markdown = { "prettierd", "prettier" },
			csharp = { "csharpier" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({
					async = true,
					lsp_format = "fallback",
				})
			end,
			mode = { "n", "v" },
			desc = "Format buffer",
		},
	},
}
