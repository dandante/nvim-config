return {
  {
    "folke/noice.nvim",
    -- 'opts' can be ignored; we'll handle it in 'config'
    config = function()
      require("noice").setup({
        -- 1. This is the big one: it turns off the pop-up messages
        -- and redirects them to the classic Neovim echo area.
        messages = {
          enabled = false,
        },
        -- 2. This turns off the fancy "fading" notification popups.
        notify = {
          enabled = false,
        },
        -- 3. We keep the command line (:) and other features enabled
        -- unless you want those gone too.
        cmdline = {
          enabled = true,
          view = "cmdline", -- Options: "cmdline_popup" (default) or "cmdline" (bottom)
        },
        lsp = {
          -- We disable the Noice progress bar so it doesn't flicker in the corner
          progress = { enabled = false },
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.set_良_markdown_lines"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- 4. Presets can help simplify things
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = false, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
        },
      })
    end,
  },
}
