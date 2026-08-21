return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = false,
	opts = {
		ensure_installed = {
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
		},
		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
		},
	},
}
