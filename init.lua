-- ** USER COMMANDS
-- copy neovim's latest yank to system clipboard
-- TODO add key mapping
vim.api.nvim_create_user_command("Epaste", function()
    vim.fn.setreg("+", vim.fn.getreg("0"))
end, {})
-- vim.cmd [[colorscheme default]]

-- If we are on a remote machine via SSH, override the clipboard
-- provider to use OSC 52.
if vim.env.SSH_TTY then
    vim.g.clipboard = {
        name = "OSC 52",
        copy = {
            ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
            ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
        },
        paste = {
            ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
            ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
        },
    }
end

-- open fish instead of bash with CTRL-/
if vim.fn.system({ "uname" }):sub(1, -2) == "Linux" then
    vim.opt.shell = vim.fn.expand("~/.fish/bin/fish")
end

-- ** PLUGINS
vim.pack.add({
    "https://github.com/akinsho/bufferline.nvim",  
    -- "https://github.com/R-nvim/R.nvim",
    "https://github.com/dandante/abc.nvim",
    "https://github.com/folke/flash.nvim",
    -- "https://github.com/saghen/blink.lib",
    -- "https://github.com/rafamadriz/friendly-snippets",
    -- {
    --     src = "https://github.com/Saghen/blink.cmp",
    --     version = "v2",
    -- },
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/L3MON4D3/LuaSnip",
    "https://github.com/folke/which-key.nvim",
    "https://github.com/nvim-lua/plenary.nvim", -- needed by telescope
    {
        -- if needed, go to ~/.local/share/$NVIM_APPNAME/site/pack/core/opt/telescope-fzf-native.nvim
        -- and run `make`
        src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },
    "https://github.com/nvim-telescope/telescope.nvim",
    -- reminder "-" goes up a level in oil:
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/kdheepak/lazygit.nvim",
    "https://github.com/folke/snacks.nvim",
})

-- ** KEYMAPS
--  USE which-key, not native keymaps for any keymaps that use the leader key
vim.g.mapleader = " "

-- ** WHICH-KEY KEYMAPS
local wk = require("which-key")
wk.add({
    {
        "<leader>.",
        function()
            vim.fn.setreg("*", vim.fn.getreg("0"))
        end,
        desc = "Reg to Ext Clipboard",
    },
    { "<leader>f", group = "file" }, -- group
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers", mode = "n" },
    { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep (Root Dir)", mode = "n" },
    { "<leader>r", "<cmd>Telescope registers<cr>", desc = "Registers", mode = "n" },
    {
        "<leader>fh",
        function()
            require("telescope.builtin").help_tags()
        end,
        desc = "help",
    },
    { "<leader>f1", hidden = true }, -- hide this keymap
    { "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
    -- {
    --  "<leader>b",
    --  group = "buffers",
    --  expand = function()
    --   return require("which-key.extras").expand.buf()
    --  end,
    -- },
    { "<leader>e", group = "edit" },
    {
        "<leader>fc",
        function()
            require("telescope.builtin").find_files({
                cwd = vim.fn.stdpath("config"),
            })
        end,
        desc = "Config",
    },
    {
        "<leader>fp",
        function()
            require("telescope.builtin").find_files({
                cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "site/pack/core/opt"),
            })
        end,
        desc = "Packages",
    },
    -- floating terminal
    {
        "<leader>ft",
        function()
            Snacks.terminal.toggle()
        end,
        desc = "Terminal (cwd)",
        mode = { "n", "i", "v", "t" },
    },
    {
        "<c-/>",
        function()
            Snacks.terminal.toggle()
        end,
        desc = "Terminal (cwd)",
        mode = { "n", "i", "v", "t" },
    },
    { "s", function() require("flash").jump() end, desc = "Flash", mode = {"n", "x", "o"} },
    { "S", function() require("flash").jump() end, desc = "Flash Treesitter", mode = {"n", "x", "o"} },
    { "r", function() require("flash").remote() end, desc = "Remote Flash", mode = "o" },
    -- { "S-h", "<cmd>bprevious<cr>", desc = "Prev Buffer" }, -- TODO fix conflict
    { "[b", "<cmd>bprevious<cr>", desc = "Prev Buffer" },
    -- { "S-l", "<cmd>bnext<cr>", desc = "Next Buffer" }, -- TODO fix conflict
    { "]b", "<cmd>bnext<cr>", desc = "Next Buffer" },

    {
        -- Nested mappings are allowed and can be added in any order
        -- Most attributes can be inherited or overridden on any level
        -- There's no limit to the depth of nesting
        mode = { "n", "v" }, -- NORMAL and VISUAL mode
        { "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
        { "<leader>w", "<cmd>w<cr>", desc = "Write" },
    },
})

-- ** ENABLE BUILT-IN THINGS
-- require("vim._core.ui2").enable()
require('vim._core.ui2').enable({
    enable = true,
    msg = {
        target = "cmd", -- options: cmd(classic), msg(similar to noice)
        pager = { height = 1 },
        msg   = { height = 0.5, timeout = 4500 },
        dialog = { height = 0.5 },
        cmd    = { height = 0.5 },
    },
})

vim.cmd.packadd("cfilter")
vim.cmd.packadd("nvim.undotree")
vim.cmd.packadd("nvim.difftool")

-- ** PLUGIN CONFIG
require("oil").setup()

require("telescope").setup({
    pickers = {
        help_tags = {
            theme = "ivy",
        },
    },
    extensions = {
        fzf = {},
    },
})

require("telescope").load_extension("fzf")

require("lualine").setup()

require('abc-nvim').setup()

vim.opt.termguicolors = true
require("bufferline").setup{}

-- ** UI CONFIG
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- ** OPTIONS
vim.opt.number = true
vim.opt.relativenumber = true
