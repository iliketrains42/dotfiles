require("config.options")
require("config.keybinds")
require("config.lazy")

require("lualine").setup()

require("nvim-treesitter.install").compilers = { "clang-cl", "zig", "gcc" }
