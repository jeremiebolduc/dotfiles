require("mason-lspconfig").setup()

-- Enable specific LSP servers natively
vim.lsp.enable({
  "lua_ls",
  "ts_ls",      -- TypeScript/JavaScript
  "rust_analyzer", -- Rust
  "gopls",      -- Go
  "roslyn-language-server",      -- C#
})
