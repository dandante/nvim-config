-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("oil").setup({
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = true,
  },
})
vim.filetype.add({
  extension = {
    ['eb'] = 'python',
  },
})

-- vim.lsp.enable('ty')

