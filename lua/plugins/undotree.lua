return {
  {
    "mbbill/undotree",
    config = function()
      -- Optional: bind a key to toggle the undotree
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })
    end
  }
}

