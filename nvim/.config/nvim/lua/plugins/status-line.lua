return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")

		local function get_hl(name, fallback)
			local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
			return hl.fg and string.format("#%06x", hl.fg) or fallback
		end

		local colors = {
			bg = "#1A1D2D",
			fg = get_hl("Comment", "#1A1D2D"),
			blue = get_hl("Function", "#7EA2EA"),
			green = get_hl("String", "#A8D475"),
			red = get_hl("DiagnosticError", "#F88199"),
			yellow = get_hl("DiagnosticWarn", "#E4B873"),
			cyan = get_hl("Type", "#7EDFD0"),
			magenta = get_hl("Statement", "#A485DA"),
			orange = get_hl("Number", "#A485DA"),
			violet = get_hl("Keyword", "#A485DA"),
			turquoise = get_hl("@field", "#73daca"),
		}

    -- Color table for highlights
    -- stylua: ignore
    -- local colors = {
    --   -- bg       = '#202328',
    --   bg       = '#171721',
    --   fg       = '#bbc2cf',
    --   yellow   = '#E4B873',
    --   cyan     = '#7EDFD0',
    --   darkblue = '#081633',
    --   green    = '#A8D475',
    --   orange   = '#FFA86F',
    --   violet   = '#a9a1e1',
    --   magenta  = '#A485DA',
    --   blue     = '#7EA2EA',
    --   red      = '#F88199',
    -- }

		local conditions = {
			buffer_not_empty = function()
				return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
			end,
			hide_in_width = function()
				return vim.fn.winwidth(0) > 80
			end,
			check_git_workspace = function()
				local filepath = vim.fn.expand("%:p:h")
				local gitdir = vim.fn.finddir(".git", filepath .. ";")
				return gitdir and #gitdir > 0 and #gitdir < #filepath
			end,
		}

		-- Config
		local config = {
			options = {
				-- Disable sections and component separators
				component_separators = "",
				section_separators = "",
				theme = {
					-- We are going to use lualine_c an lualine_x as left and
					-- right section. Both are highlighted by c theme .  So we
					-- are just setting default looks o statusline
					normal = { c = { fg = colors.fg, bg = colors.bg } },
					inactive = { c = { fg = colors.fg, bg = colors.bg } },
				},
			},
			sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				-- These will be filled later
				lualine_c = {},
				lualine_x = {},
			},
			inactive_sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
		}

		-- Inserts a component in lualine_c at left section
		local function ins_left(component)
			table.insert(config.sections.lualine_c, component)
		end

		-- Inserts a component in lualine_x at right section
		local function ins_right(component)
			table.insert(config.sections.lualine_x, component)
		end

		local mode_color = {
			n = colors.blue,
			i = colors.green,
			v = colors.yellow,
			[""] = colors.blue,
			V = colors.blue,
			c = colors.magenta,
			no = colors.red,
			s = colors.orange,
			S = colors.orange,
			[""] = colors.orange,
			ic = colors.yellow,
			R = colors.violet,
			Rv = colors.violet,
			cv = colors.red,
			ce = colors.red,
			r = colors.cyan,
			rm = colors.cyan,
			["r?"] = colors.cyan,
			["!"] = colors.red,
			t = colors.red,
		}

		ins_left({
			-- mode component
			function()
				return ""
			end,
			color = function()
				-- auto change color according to neovims mode
				return { fg = mode_color[vim.fn.mode()] }
			end,
		})

		ins_left({
			"filename",
			cond = conditions.buffer_not_empty,
			color = { fg = colors.magenta, gui = "bold" },
		})

		ins_left({
			"branch",
			icon = "",
			color = { fg = colors.cyan, gui = "bold" },
		})

		ins_left({
			"diff",
			-- Is it me or the symbol for modified us really weird
			symbols = { added = " ", modified = " ", removed = " " },
			diff_color = {
				added = { fg = colors.green },
				modified = { fg = colors.yellow },
				removed = { fg = colors.red },
			},
			cond = conditions.hide_in_width,
		})

		ins_right({
			"diagnostics",
			sources = { "nvim_diagnostic" },
			symbols = { error = " ", warn = " ", info = " " },
			diagnostics_color = {
				error = { fg = colors.red },
				warn = { fg = colors.yellow },
				info = { fg = colors.cyan },
			},
		})

		ins_right({
			-- Lsp server name .
			function()
				local msg = "{!}"
				local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
				local clients = vim.lsp.get_clients()
				if next(clients) == nil then
					return msg
				end
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						return string.format("{%s}", client.name)
					end
				end
				return msg
			end,
			icon = " ",
			color = { fg = colors.turquoise, gui = "bold" },
		})

		-- Add components to right sections
		ins_right({
			"o:encoding",
			cond = conditions.hide_in_width,
			color = { fg = colors.green, gui = "bold" },
		})

		ins_right({
			"fileformat",
			icons_enabled = false,
			color = { fg = colors.green, gui = "bold" },
		})

		-- ins_right({
		-- 	function()
		-- 		return "▊"
		-- 	end,
		-- 	color = { fg = colors.blue },
		-- 	padding = { left = 1 },
		-- })

		lualine.setup(config)
	end,
}
