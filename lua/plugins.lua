-- lua/plugins.lua

-- Define plugins (Note the double curly braces: it must be a list of tables)
vim.pack.add({
  {
    src = "https://github.com/folke/which-key.nvim",
  }
})

-- Configuration sections
local wk = require("which-key")
wk.setup({
  preset = "modern", 
})

-- note that the default leader key is \

vim.keymap.set("n", "<leader>?", function()
  wk.show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })

-- 2. Trigger menu on leader in Visual mode
vim.keymap.set("v", "<leader>", function()
  require("which-key").show()
end, { desc = "Keys (Visual)" })

