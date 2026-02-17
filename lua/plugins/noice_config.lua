return {
  {
    "folke/noice.nvim",
    opts = {
      -- Disables noice rendering for messages and print statements
      messages = {
        enabled = false,
      },
      -- Disables the fancy notification popups (reverts to standard vim.notify)
      notify = {
        enabled = false,
      },
      -- Ensures the lsp/print messages go to the classic Neovim "echo" area
      lsp = {
        progress = { enabled = false }, -- optional: keeps progress in statusline
      },
    },
  },
}
