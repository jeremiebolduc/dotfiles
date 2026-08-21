-- Universal test runner: one core API/UI, per-language adapters underneath.
local function patch_neotest_dotnet_nvim011_compat(plugin)
  -- neotest-dotnet issue #145: nvim 0.11+ changed Query:iter_matches to always
  -- return TSNode[] per capture slot (even with `{ all = false }`), breaking
  -- framework detection. Patch is idempotent and reapplies after updates.
  local path = plugin.dir .. "/lua/neotest-dotnet/framework-discovery.lua"
  local file = io.open(path, "r")
  if not file then
    return
  end
  local content = file:read("*a")
  file:close()

  if content:find("nvim 0.11%+ changed iter_matches", 1, false) then
    return -- already patched
  end

  local old = [[  for _, captures, _ in parsed_query:iter_matches(root, source, nil, nil, { all = false }) do
    local test_attribute = vim.fn.has("nvim-0.9.0") == 1
        and vim.treesitter.get_node_text(captures[1], source)
      or vim.treesitter.query.get_node_text(captures[1], source)
    if test_attribute then]]

  local new = [[  for _, captures, _ in parsed_query:iter_matches(root, source, nil, nil, { all = false }) do
    -- nvim 0.11+ changed iter_matches to always return TSNode[] per capture slot
    -- instead of a single TSNode, even with { all = false }. Unwrap it here.
    local capture_node = captures[1]
    if type(capture_node) == "table" then
      capture_node = capture_node[1]
    end
    local test_attribute = capture_node
      and (
        vim.fn.has("nvim-0.9.0") == 1 and vim.treesitter.get_node_text(capture_node, source)
        or vim.treesitter.query.get_node_text(capture_node, source)
      )
    if test_attribute then]]

  local patched, count = content:gsub(vim.pesc(old), (new:gsub("%%", "%%%%")), 1)
  if count == 0 then
    vim.notify("neotest-dotnet: compat patch target not found, skipping", vim.log.levels.WARN)
    return
  end

  local out = io.open(path, "w")
  if out then
    out:write(patched)
    out:close()
  end
end

return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "fredrikaverpil/neotest-golang",
    {
      "Issafalcon/neotest-dotnet",
      build = patch_neotest_dotnet_nvim011_compat,
    },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-golang"),
        require("neotest-dotnet"),
      },
    })

    local neotest = require("neotest")

    vim.keymap.set("n", "<leader>tt", function()
      neotest.run.run()
    end, { desc = "Run nearest test" })

    vim.keymap.set("n", "<leader>tf", function()
      neotest.run.run(vim.fn.expand("%"))
    end, { desc = "Run current file" })

    vim.keymap.set("n", "<leader>tS", function()
      neotest.run.stop()
    end, { desc = "Stop test" })

    vim.keymap.set("n", "<leader>to", function()
      neotest.output.open({ enter = true })
    end, { desc = "Show test output" })

    vim.keymap.set("n", "<leader>ts", function()
      neotest.summary.toggle()
    end, { desc = "Toggle test summary" })

    vim.keymap.set("n", "<leader>tw", function()
      neotest.watch.toggle(vim.fn.expand("%"))
    end, { desc = "Watch current file" })
  end,
}
