-- nvim-treesitter's "main" branch (rewrite) does not support the legacy
-- ensure_installed/highlight/indent options; parsers must be installed
-- explicitly and highlighting/indent enabled per-filetype ourselves.
local parsers = {
	"c_sharp",
	"go",
	"gomod",
	"gosum",
	"gowork",
	"javascript",
	"json",
	"lua",
	"markdown",
	"markdown_inline",
	"rust",
	"typescript",
	"vim",
	"vimdoc",
}

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		require("nvim-treesitter").install(parsers)

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
			callback = function()
				-- Silently no-op for filetypes without an installed parser.
				pcall(vim.treesitter.start)
				pcall(function()
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end)
			end,
		})
	end,
}
