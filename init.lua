vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Setting options ]]
-- See `:help vim.opt`
--  For more options, you can see `:help option-list`

vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search
vim.opt.hlsearch = true

vim.opt.list = false

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

vim.keymap.set("n", "<CR>", "ciw")
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "jk", "<Esc>")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<C-a>", "ggVG") -- Select all

-- Resize split with arrows
vim.keymap.set("n", "<C-S-Up>", "<cmd>resize +1<CR>")
vim.keymap.set("n", "<C-S-Down>", "<cmd>resize -1<CR>")
vim.keymap.set("n", "<C-S-Left>", "<cmd>vertical resize -1<CR>")
vim.keymap.set("n", "<C-S-Right>", "<cmd>vertical resize +1<CR>")

-- Buffer
vim.keymap.set("n", "<S-l>", "<Cmd>bnext<CR>")
vim.keymap.set("n", "<S-h>", "<Cmd>bprevious<CR>")
vim.keymap.set("n", "<Leader>ww", "<Cmd>bdelete<CR>")

-- Move text up and down
vim.keymap.set("n", "<A-j>", "<Cmd>move .+1<CR>==")
vim.keymap.set("n", "<A-k>", "<Cmd>move .-2<CR>==")

-- Move block up and downj
vim.keymap.set("x", "<A-j>", "<Cmd>m'>+<CR>gv=gv")
vim.keymap.set("x", "<A-k>", "<Cmd>m-2<CR>gv=gv")

vim.keymap.set("v", "<Leader>y", '"+y') -- Copy to clipboard

-- Stay in visual mode when indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("v", "p", '"_dP') -- Replace the selection with the yank

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!"<CR>')

vim.keymap.set("n", "<C-1>", "<cmd>NvimTreeToggle<CR>")

vim.keymap.set("n", "<leader>ge", "<cmd>GoIfErr<CR>")
vim.keymap.set("n", "<leader>gt", "<cmd>GoAddTag<CR>")

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins, you can run
--    :Lazy update
--
require("lazy").setup({
  { "tpope/vim-sleuth" },
  { "numToStr/Comment.nvim", opts = {} },
  { "kylechui/nvim-surround", opts = {} },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    opts = {},
  },

  require "user.plugins.lspconfig",
  require "user.plugins.debug",
  require "user.plugins.indent_line",
  require "user.plugins.gitsigns",
  require "user.plugins.treesitter",
  require "user.plugins.which-key",
  require "user.plugins.telescope",
  require "user.plugins.autoformat",
  require "user.plugins.cmp",
  require "user.plugins.colorscheme",
  require "user.plugins.nvim-tree",
  require "user.plugins.lualine",
  require "user.plugins.toggleterm",
  require "user.plugins.go-nvim",

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
