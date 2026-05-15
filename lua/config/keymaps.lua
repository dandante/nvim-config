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

local wk = require("which-key")
wk.add({
    {
      "<leader>.",
      function()
          vim.fn.setreg("+", vim.fn.getreg("0"))
      end,
      desc = "Reg to Ext Clipboard",
  },
  { "<leader>=", group = "Flash" }, -- group
  {
    "<leader>=s",
    function()
      require("flash").jump()
    end,
    desc = "Jump",
  },
})

-- keys for resizing windows
-- Resize windows using Alt + hjkl
vim.keymap.set("n", "<M-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<M-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
vim.keymap.set("n", "<M-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<M-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })

-- OR use Alt + hjkl if you prefer no arrows at all:
vim.keymap.set("n", "<M-h>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<M-l>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
vim.keymap.set("n", "<M-k>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<M-j>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
