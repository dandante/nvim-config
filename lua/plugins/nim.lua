require("lspconfig").nim_langserver.setup({
  settings = {
    nim = {
      nimsuggestPath = "~/.nimble/bin/nimlangserver",
    },
  },
})

return {
  "alaviss/nim.nvim",
}
