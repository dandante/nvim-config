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

-- open fish instead of bash with CTRL-/
if vim.fn.system({ "uname" }):sub(1, -2) == "Linux" then
  vim.opt.shell = vim.fn.expand("~/.fish/bin/fish")
end

vim.opt.inccommand = "split"
vim.opt.spell = false

-- Custom user commands

-- fix happyfox vertical space issue in markdown mode
vim.api.nvim_create_user_command("Happyfix", "%s/\\n\\n/\\r\\&nbsp;\\r/g", {})
-- related: remove non-breaking spaces and preceding newline
vim.api.nvim_create_user_command("Unhappy", "%s/\n%u00a0//g", {})
vim.api.nvim_create_user_command("Backslash2Slash", "snomagic!\\\\!/!g", {})
vim.api.nvim_create_user_command("RmBackslash", "snomagic!\\\\!!g", {})
-- erase all contents of buffer, go to insert mode
vim.api.nvim_create_user_command("Deldoc", function()
  vim.cmd('keepjumps norm! ggVG"_d')
  vim.cmd("startinsert")
end, {})
-- convert bash style exports to fish style:
vim.api.nvim_create_user_command("Fishify", function()
  local view = vim.fn.winsaveview()

  -- 1. Replace 'export ' with 'set -x '
  -- The 'g' flag handles multiple exports on one line (if they exist)
  vim.cmd([[silent! %s/export /set -x /g]])

  -- 2. Replace '=' with ' ' (a single space)
  -- This will turn KEY="value" into KEY "value"
  -- and KEY=value into KEY value
  vim.cmd([[silent! %s/=/ /]])

  vim.fn.winrestview(view)
  print("Bash exports converted to Fish style!")
end, { desc = "Convert bash exports to fish set -x" })

vim.opt.swapfile = false

local function open_messages_floating()
  -- Get the messages
  local messages = vim.fn.execute("messages")

  -- Create a new buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(messages, "\n"))

  -- Calculate window size (80% of editor)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Open the floating window
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  -- Optional: Set filetype to markdown for some basic highlighting
  vim.bo[buf].filetype = "bash"
end

-- Keymap to trigger it
vim.keymap.set("n", "<leader>ms", open_messages_floating, { desc = "Show Messages in Float" })

vim.g.autoformat = false
