return {
  "hkupty/iron.nvim",
  lazy = false,
  config = function()
    local iron = require("iron.core")
    local ok, wk = pcall(require, "which-key")
    if ok then
      wk.add({ { "<leader>r", group = "REPL" } })
    end
    iron.setup({
      config = {
        repl_open_cmd = require("iron.view").bottom(20),
        repl_definition = {
          -- 1. Explicitly handle empty filetypes (unsaved buffers)
          [""] = { command = { "fish" } },
          -- 2. Handle standard shell files
          sh = { command = { "fish" } },
          -- 3. The general fallback
          ["*"] = { command = { "fish" } }, 
        },
      },
      should_set_cursor = false,
    })

    -- Keymaps
    --- The corrected keymaps using Lua functions instead of Vim commands
    local map = vim.keymap.set
    -- Open the REPL
    map("n", "<leader>rc", "<cmd>IronRepl<cr>", { desc = "Iron: Toggle REPL" })
    
    -- Send the current line
    map("n", "<leader>rl", function()
      require("iron.core").send_line()
    end, { desc = "Iron: Send Line" })

    -- Send visual selection (if you ever need to send multiple lines)
    map("v", "<leader>rr", function()
      require("iron.core").visual_send()
    end, { desc = "Iron: Send Selection" })
  end,
}
