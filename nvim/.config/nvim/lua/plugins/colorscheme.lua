-- return {
-- 	"folke/tokyonight.nvim",
-- 	lazy = false, -- make sure we load this during startup if it is your main colorscheme
-- 	priority = 1000, -- make sure to load this before all the other start plugins
-- 	config = function()
-- 		-- load the colorscheme here
-- 		vim.cmd([[colorscheme tokyonight-night]])
-- 	end,
-- }
return { 
  "EdenEast/nightfox.nvim",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
		vim.cmd([[colorscheme nightfox]])
  end,
}
-- return {
-- 	"catppuccin/nvim",
-- 	lazy = false,
-- 	name = "catppuccin",
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd([[colorscheme catppuccin-mocha]])
-- 	end,
-- }
-- return {
--   "Mofiqul/dracula.nvim" ,
-- 	lazy = false,
-- 	name = "dracula",
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd([[colorscheme dracula]])
-- 	end,
-- }
