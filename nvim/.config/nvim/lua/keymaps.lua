vim.keymap.set("n", "rn", vim.lsp.buf.rename, { desc = "LSP Rename" })

-- Copy to system clipboard
vim.keymap.set({ "n", "v" }, "Y", '"+yy', { desc = "Y = yy" })
vim.keymap.set({ "n", "v" }, "y", '"+y', { desc = "Yank to system clipboard" })

-- Paste from system clipboard in Normal and Visual modes
vim.keymap.set({ "n", "v" }, "P", '"+P', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "p", '"+p', { desc = "Paste from system clipboard" })

-- Delete to system clipboard in Normal and Visual modes
vim.keymap.set({ "n", "v" }, "D", '"+dd', { desc = "D = dd" })
vim.keymap.set({ "n", "v" }, "d", '"+d', { desc = "Delete to system clipboard" })

-- Don't overwrite yank register when pasting over a selection.
vim.keymap.set("x", "p", [["_dP]], { desc = "Paste without yanking replaced text" })

-- Scroll half-page down and center cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half-page down and center" })

-- Scroll half-page up and center cursor
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half-page up and center" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- Keep selection while indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Move selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Remap ctrl+c to esc for same behaviour
vim.keymap.set("i", "<C-c>", "<Esc>", { noremap = true })

-- Toggle relative line number
vim.keymap.set("n", "<leader>ur", function()
    vim.wo.relativenumber = not vim.wo.relativenumber
end, { desc = "Toggle relative line numbers" })

