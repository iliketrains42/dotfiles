return {
    "mfussenegger/nvim-lint",
    event = {
        "BufReadPre",
        "BufNewFile",
    },

    config = function()
        local lint = require("lint")

        -- Define luacheck custom configuration
        lint.linters.luacheck = {
            cmd = "luacheck",
            stdin = true,
            args = {
                "--globals",
                "vim",
                "lvim",
                "reload",
                "--",
            },
            stream = "stdout",
            ignore_exitcode = true,
            parser = require("lint.parser").from_errorformat("%f:%l:%c: %m", {
                source = "luacheck",
            }),
        }

        -- Filetype-to-linter mapping
        lint.linters_by_ft = {
            javascript = { "eslint_d" },
            python = { "pylint" },
            cpp = { "cpplint" },
            lua = { "luacheck" },
        }

        -- Autocommand for linting on certain events
        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
