-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Map <leader>h to open the Dashboard
vim.keymap.set("n", "<leader>h", function()
  if package.loaded["snacks"] then
    Snacks.dashboard.open()
  else
    vim.cmd("Alpha") -- Fallback for older setups
  end
end, { desc = "Go to Dashboard" })
