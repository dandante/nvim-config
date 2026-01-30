return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      -- 1. Prevent the plugin from overriding your conceal settings
      win_options = {
        conceallevel = {
          default = 0,
          rendered = 0,
        },
      },
      heading = {
        -- This disables the circle icons and replacements
        enabled = false,
        -- If you want to keep some styling but see the hashes,
        -- you can set 'sign = false' and 'icons = {}' instead of 'enabled = false'
      },
      code = {
        -- 2. Turn off the 'sign' (the icon/bar on the left)
        -- so it doesn't mask the backticks
        sign = false,
        -- 3. This ensures the backticks are rendered normally
        style = "normal",
        -- 4. Keep the background highlight if you like it,
        -- but prevent it from shifting text
        width = "block",
      },
    },
  },
}
