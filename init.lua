
-- If we wanted to change the leader key from the default (\) we'd uncomment:
-- SET THIS FIRST
--vim.g.mapleader = " "
--vim.g.maplocalleader = " "

require("plugins")

-- Helper mapping to update plugins (new in 0.12)
vim.keymap.set("n", "<leader>pu", vim.pack.update, { desc = "Update Plugins" })




