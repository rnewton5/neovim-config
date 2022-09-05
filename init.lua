-- Speeds up startup time
-- https://github.com/lewis6991/impatient.nvim
pcall(require, "impatient")

require("colorscheme")
require("options")
require("keymaps").general()
require("plugins")

