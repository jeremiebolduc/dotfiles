local M = {}

-- These are nvim-lspconfig server names. mason-lspconfig translates them to
-- the corresponding Mason packages, installs missing servers, and enables them.
M.servers = {
	"lua_ls",
	"ts_ls",
	"rust_analyzer",
	"gopls",
	"roslyn_ls",
  "yamlls",
  "terraform-ls"
}

function M.setup(mason_opts)
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	-- Apply completion capabilities to every server, including any added later.
	vim.lsp.config("*", {
		capabilities = capabilities,
	})

	-- Give lua-language-server an accurate view of Neovim's Lua environment.
	vim.lsp.config("lua_ls", {
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				workspace = {
					checkThirdParty = false,
					library = { vim.env.VIMRUNTIME },
				},
			},
		},
	})

	-- Mason's NuGet package exposes this command name. nvim-lspconfig's default
	-- still targets the executable name used by older standalone distributions.
	vim.lsp.config("roslyn_ls", {
		cmd = {
			"roslyn-language-server",
			"--logLevel",
			"Information",
			"--extensionLogDirectory",
			vim.fs.joinpath(vim.uv.os_tmpdir(), "roslyn_ls", "logs"),
			"--stdio",
		},
	})

	require("mason-lspconfig").setup(mason_opts)
end

return M
