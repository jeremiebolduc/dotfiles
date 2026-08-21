return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- optional but recommended
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
		vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "List LSP references for word under the cursor" })
		vim.keymap.set(
			"n",
			"gI",
			builtin.lsp_incoming_calls,
			{ desc = "List LSP incoming calls for word under the cursor" }
		)
		vim.keymap.set(
			"n",
			"gO",
			builtin.lsp_outgoing_calls,
			{ desc = "List LSP outgoing calls for word under the cursor" }
		)
		vim.keymap.set(
			"n",
			"gi",
			builtin.lsp_implementations,
			{ desc = "Goto implementation for word under the cursor" }
		)
		vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Goto definition for word under the cursor" })
		vim.keymap.set(
			"n",
			"gt",
			builtin.lsp_type_definitions,
			{ desc = "Goto type definition for word under the cursor" }
		)
		vim.api.nvim_create_autocmd("User", {
			pattern = "TelescopePreviewerLoaded",
			callback = function(args)
				if args.data.filetype ~= "help" then
					vim.wo.number = true
				end

				local bufname = args.data.bufname

				if not bufname then
					return
				end

				if args.data.bufname:match("%.lua$") then
					vim.bo.tabstop = 2
					vim.bo.shiftwidth = 2
					vim.bo.softtabstop = 2
					vim.bo.expandtab = false
				else
					vim.bo.tabstop = 4
					vim.bo.shiftwidth = 4
					vim.bo.softtabstop = 4
					vim.bo.expandtab = false
				end
			end,
		})
		vim.keymap.set(
			"n",
			"gI",
			builtin.lsp_incoming_calls,
			{ desc = "List LSP incoming calls for word under the cursor" }
		)
		vim.keymap.set(
			"n",
			"gO",
			builtin.lsp_outgoing_calls,
			{ desc = "List LSP outgoing calls for word under the cursor" }
		)
		vim.keymap.set(
			"n",
			"gi",
			builtin.lsp_implementations,
			{ desc = "Goto implementation for word under the cursor" }
		)
		vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Goto definition for word under the cursor" })
		vim.keymap.set(
			"n",
			"gt",
			builtin.lsp_type_definitions,
			{ desc = "Goto type definition for word under the cursor" }
		)
		vim.api.nvim_create_autocmd("User", {
			pattern = "TelescopePreviewerLoaded",
			callback = function(args)
				if args.data.filetype ~= "help" then
					vim.wo.number = true
				end

				local bufname = args.data.bufname

				if not bufname then
					return
				end

				if args.data.bufname:match("%.lua$") then
					vim.bo.tabstop = 2
					vim.bo.shiftwidth = 2
					vim.bo.softtabstop = 2
					vim.bo.expandtab = false
				else
					vim.bo.tabstop = 4
					vim.bo.shiftwidth = 4
					vim.bo.softtabstop = 4
					vim.bo.expandtab = false
				end
			end,
		})
	end,
}
