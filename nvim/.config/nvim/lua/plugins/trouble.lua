return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  dependencies = { "nvim-mini/mini.icons" },
  opts = {},
  keys = {
    { "<leader>dd", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (workspace)" },
    { "<leader>db", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics (buffer)" },
    { "<leader>dq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
    { "<leader>dl", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
    { "<leader>ds", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
    { "<leader>dT", "<cmd>Trouble todo toggle<cr>", desc = "Todos (Trouble)" },
  },
}
