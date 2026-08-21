return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    delay = 300,
    spec = {
      { "<leader>c", group = "Code" },
      { "<leader>d", group = "Diagnostics" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>u", group = "UI" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer-local keymaps",
    },
  },
}
