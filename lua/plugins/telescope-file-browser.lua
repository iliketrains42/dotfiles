return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    lazy = false, -- ensure it loads immediately
    priority = 1000, -- make damn sure it loads before anything else
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
    },
    keys = {
        {
            "<leader>tf",
            function()
                require("telescope.builtin").find_files()
            end,
            desc = "Find files",
        },
        {
            "<leader>tg",
            function()
                require("telescope.builtin").live_grep()
            end,
            desc = "Live grep",
        },
        {
            "<leader>tb",
            function()
                require("telescope.builtin").buffers()
            end,
            desc = "Buffers",
        },
        {
            "<leader>th",
            function()
                require("telescope.builtin").help_tags()
            end,
            desc = "Help tags",
        },
        {
            "<leader>cd",
            "<cmd>Telescope file_browser<CR>",
            desc = "File browser",
        },
        {
            "<leader>q",
            function()
                vim.cmd("bd")
                vim.cmd("Telescope file_browser")
            end,
            desc = "Close buffer + reopen file browser",
            noremap = true,
            silent = true,
        },
    },
    config = function()
        local telescope = require("telescope")

        telescope.setup({
            extensions = {
                file_browser = {
                    hijack_netrw = true,
                },
            },
        })

        telescope.load_extension("file_browser")
    end,
}
