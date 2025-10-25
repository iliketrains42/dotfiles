return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local keymap = vim.keymap
        local lspconfig_util = require("lspconfig.util")

        -- Buffer-local keymaps for LSP
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local opts = { buffer = ev.buf, silent = true }

                keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
                keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
                keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
                keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
                keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
                keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                keymap.set("n", "K", vim.lsp.buf.hover, opts)
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
            end,
        })

        -- Completion capabilities
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- Diagnostic symbols
        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.WARN] = " ",
                    [vim.diagnostic.severity.INFO] = " ",
                },
            },
        })

        -- Default config for all servers
        vim.lsp.config("*", { capabilities = capabilities })

        -- Lua
        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                    completion = { callSnippet = "Replace" },
                },
            },
        })

        -- Clangd
        vim.lsp.config("clangd", {
            cmd = { "clangd" },
            filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
            root_markers = {
                ".clangd",
                ".clang-tidy",
                ".clang-format",
                "compile_commands.json",
                "compile_flags.txt",
                "configure.ac", -- AutoTools
                ".git",
            },
            on_attach = function(client)
                client.server_capabilities.signatureHelpProvider = false
            end,
        })

        -- BasedPyright (Python)
        vim.lsp.config("basedpyright", {
            cmd = { "basedpyright-langserver", "--stdio" },
            filetypes = { "python" },
            on_attach = function(client, bufnr)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.semanticTokensProvider = nil
                -- require("lsp.attach").on_attach(client, bufnr)
            end,
            --capabilities = require("lsp.attach").capabilities,
            settings = {
                basedpyright = {
                    analysis = {
                        autoSearchPaths = true,
                        diagnosticMode = "openFilesOnly",
                        useLibraryCodeForTypes = true,
                        typeCheckingMode = "all",
                        diagnosticSeverityOverrides = {
                            reportAny = false,
                            reportMissingTypeArgument = false,
                            reportMissingTypeStubs = false,
                            reportUnknownArgumentType = false,
                            reportUnknownMemberType = false,
                            reportUnknownParameterType = false,
                            reportUnknownVariableType = false,
                            reportUnusedCallResult = false,
                        },
                    },
                },
                python = {},
            },
            before_init = function(_, config)
                local python_path = vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
                config.settings.python.pythonPath = python_path
                vim.notify(python_path)
            end,
        })
    end,
}
