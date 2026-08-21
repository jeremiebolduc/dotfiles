return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = false,
	opts = {
		ensure_installed = {
			"lua",
			"vim",
			"vimdoc",
			"go",
			"gomod",
			"gowork",
			"gosum",
			"rust",
      "c_sharp",
		},
		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
		},
	},
}
