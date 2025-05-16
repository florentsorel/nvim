vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.loaded_netrwPlugin = 0

vim.g.have_nerd_font = true

-- [[ Basic settings ]]
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.laststatus = 3

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = false
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<Enter>", "ciw")
vim.keymap.set("i", "jj", "<ESC>")

vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands

-- Resize split with arrows
vim.keymap.set("n", "<C-Up>", "<cmd>resize +1<CR>")
vim.keymap.set("n", "<C-Down>", "<cmd>resize -1<CR>")
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -1<CR>")
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +1<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })

vim.keymap.set("n", "K", function()
  local open_floats = false
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_win_close(win, false)
      open_floats = true
    end
  end

  if open_floats then
    return
  end

  vim.lsp.buf_request(0, "textDocument/hover", vim.lsp.util.make_position_params(0, "utf-8"), function(_, result, _, _)
    if not (result and result.contents) then
      return
    end

    local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)

    if vim.tbl_isempty(markdown_lines) then
      return
    end

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.3)

    vim.lsp.util.open_floating_preview(markdown_lines, "markdown", {
      border = "rounded",
      max_width = width,
      max_height = height,
    })
  end)
end)

vim.diagnostic.config({
  signs = true,
  underline = true,
  update_in_insert = false,
  float = {
    show_header = true,
    border = "rounded",
    focusable = false,
  },
  virtual_text = {
    spacing = 8,
  },
})

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

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  require "user.plugins.telescope",

  require "user.plugins.auto_session",

  require "user.plugins.autopairs",
  require "user.plugins.surround",
  require "user.plugins.indent_line",
  require "user.plugins.gitsigns",
  require "user.plugins.neo-tree",
  require "user.plugins.lint",

  -- Diagnostic
  require "user.plugins.trouble",

  -- Delve
  require "user.plugins.debug",

  -- LSP Plugins
  require "user.plugins.lazydev",
  require "user.plugins.lspconfig",

  require "user.plugins.treesitter",
  require "user.plugins.symbol_outline",

  require "user.plugins.go_nvim",

  -- Autoformat
  require "user.plugins.conform",

  -- Autocompletion
  require "user.plugins.cmp",

  -- Theme
  require "user.plugins.colorscheme",
  require "user.plugins.lualine",

  -- Terminal
  require "user.plugins.toggleterm",

  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
  -- Highlight todo, notes, etc in comments
  { "folke/todo-comments.nvim", event = "VimEnter", dependencies = { "nvim-lua/plenary.nvim" }, opts = { signs = false } },

  {
    "arnamak/stay-centered.nvim",
    keys = {
      { "<leader>st", '<cmd>lua require("stay-centered").toggle()<CR>', desc = "Enable / Disabled centered mode" },
    },
  },

  { "nvim-pack/nvim-spectre" },

  { "github/copilot.vim" },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  require "user.plugins.which_key",
}, {
  ui = {
    border = "rounded",
    size = {
      width = 0.8,
      height = 0.8,
    },
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.c", "*.h", "*.cpp", "*.hpp" },
  callback = function()
    local save_cursor = vim.api.nvim_win_get_cursor(0)
    vim.cmd "%!clang-format"
    vim.api.nvim_win_set_cursor(0, save_cursor)
  end,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
