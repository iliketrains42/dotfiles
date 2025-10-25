vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"
vim.keymap.set("n", "<leader>cd", ":Telescope file_browser<CR>")
vim.keymap.set("n", "<leader>q", function()
    vim.cmd("bd")
    vim.cmd("Telescope file_browser")
end, { noremap = true, silent = true })
