return {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    event = "LspAttach",

    opts = {
        backend = "vim",
        picker = "telescope",

        backend_opts = {
            delta = {
                header_lines_to_remove = 4,
                args = {
                    "--line-numbers",
                },
            },
            difftastic = {
                header_lines_to_remove = 1,
                args = {
                    "--color=always",
                    "--display=inline",
                    "--syntax-highlight=on",
                },
            },
            diffsofancy = {
                header_lines_to_remove = 4,
            },
        },

        resolve_timeout = 100,

        notify = {
            enabled = true,
            on_empty = true,
        },

        format_title = nil,

        signs = {
            quickfix = { "", { link = "DiagnosticWarning" } },
            others = { "", { link = "DiagnosticWarning" } },
            refactor = { "", { link = "DiagnosticInfo" } },
            ["refactor.move"] = { "󰪹", { link = "DiagnosticInfo" } },
            ["refactor.extract"] = { "", { link = "DiagnosticError" } },
            ["source.organizeImports"] = { "", { link = "DiagnosticWarning" } },
            ["source.fixAll"] = { "󰃢", { link = "DiagnosticError" } },
            source = { "", { link = "DiagnosticError" } },
            rename = { "󰑕", { link = "DiagnosticWarning" } },
            codeAction = { "", { link = "DiagnosticWarning" } },
        },
    },

    keys = {
        {
            "<leader>ca",
            function()
                require("tiny-code-action").code_action()
            end,
            mode = { "n", "x" },
            desc = "Code action",
        },
        {
            "<leader>cr",
            function()
                require("tiny-code-action").code_action({
                    context = { only = { "refactor" } },
                })
            end,
            mode = { "n", "x" },
            desc = "Refactor",
        },
        {
            "<leader>cq",
            function()
                require("tiny-code-action").code_action({
                    context = { only = { "quickfix" } },
                })
            end,
            mode = { "n", "x" },
            desc = "Quick fix",
        },
    },
}
