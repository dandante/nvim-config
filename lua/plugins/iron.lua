return {
  "hkupty/iron.nvim",
  lazy = false,
  config = function()
    local iron = require("iron.core")
    local ok, wk = pcall(require, "which-key")
    if ok then
    wk.add({
        { "<leader>r", group = "REPL", mode = { "n", "v" } },
      })
    end
    iron.setup({
      config = {
        -- repl_open_cmd = require("iron.view").bottom(20),
        repl_open_cmd = "horizontal botright 20split",
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

    -- Normal Mode: Send a Register
    -- If you just hit Enter at the prompt, it sends the default (") register
    map("n", "<leader>rr", function()
      local reg = vim.fn.input("Register (default: \"): ")
      if reg == "" then reg = '"' end
      local content = vim.fn.getreg(reg)
  -- Ensure we have something to send
      if content ~= "" then
        iron.send(nil, content)
      else
        print("Register " .. reg .. " is empty")
      end
    end, { desc = "Send Register Content" })

    -- Send visual selection (if you ever need to send multiple lines)
    map("v", "<leader>rr", function()
      require("iron.core").visual_send()
    end, { desc = "Iron: Send Selection" })
  end,
}
