return {
  "nvim-treesitter/nvim-treesitter-context",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = "BufReadPost",
  opts = {
    max_lines = 3,
    min_window_height = 10,
  },
  keys = {
    { "<leader>uc", "<cmd>TSContextToggle<cr>", desc = "Toggle sticky context" },
  },
}
