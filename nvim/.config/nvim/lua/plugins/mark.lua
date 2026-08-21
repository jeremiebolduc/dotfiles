return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup()

		vim.keymap.set("n", "hh", function()
			harpoon:list():add()
		end, { desc = "Harpoon add file" })

		vim.keymap.set("n", ";", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Harpoon menu" })

		for index = 1, 5 do
			vim.keymap.set("n", tostring(index), function()
				harpoon:list():select(index)
			end, { desc = "Harpoon file " .. index })
		end

		vim.keymap.set("n", "h[", function()
			harpoon:list():prev()
		end, { desc = "Previous Harpoon file" })

		vim.keymap.set("n", "h]", function()
			harpoon:list():next()
		end, { desc = "Next Harpoon file" })
	end,
}
