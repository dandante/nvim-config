-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- vim.opt.relativenumber=false
vim.opt.laststatus = 3 -- Always show a single global statusline at the bottom
-- Always use the system clipboard for yanking/pasting
vim.opt.clipboard = "unnamedplus"

-- If we are on a remote machine via SSH, override the clipboard
-- provider to use OSC 52.
if vim.env.SSH_TTY then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
end

-- a macro to change bash style exports to fish style:
-- run it with @q
vim.fn.setreg(
  "q",
  [[:%s/export /set -x /g
:%s/=".\@=/ "/g
]]
)
