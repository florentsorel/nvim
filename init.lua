vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.loaded_netrwPlugin = 0
vim.g.have_nerd_font = true

-- UI
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.showmode = false
vim.o.laststatus = 3
vim.o.signcolumn = "yes"
vim.o.scrolloff = 10
vim.o.inccommand = "split"

-- Windows
vim.o.splitright = true
vim.o.splitbelow = true

-- Indentation
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.breakindent = true
vim.opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣",
}

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Completion
vim.opt.completeopt = "menu,menuone,noselect,popup"

-- Performance
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Misc
vim.o.mouse = "a"
vim.o.undofile = true
vim.o.confirm = true

-- Clipboard inside schedule avoids startup delay with external providers (xclip, pbcopy...)
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- Winbar (hidden when single window)
local function update_winbar()
  local multiple_windows = vim.fn.winnr("$") > 1
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    -- Skip floating windows
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      goto continue
    end
    if multiple_windows then
      vim.wo[win].winbar = win == vim.api.nvim_get_current_win() and "%=%m %f" or "%=%m %F"
    else
      vim.wo[win].winbar = ""
    end
    ::continue::
  end
end

vim.api.nvim_create_autocmd({ "WinEnter", "WinLeave", "BufEnter", "WinNew", "WinClosed" }, {
  callback = update_winbar,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Keymaps
vim.keymap.set("n", "<Left>", "<Nop>")
vim.keymap.set("n", "<Right>", "<Nop>")
vim.keymap.set("n", "<Up>", "<Nop>")
vim.keymap.set("n", "<Down>", "<Nop>")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("i", "jj", "<Esc>")

vim.keymap.set("n", "<C-Up>", "<cmd>resize +1<CR>")
vim.keymap.set("n", "<C-Down>", "<cmd>resize -1<CR>")
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -1<CR>")
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +1<CR>")

vim.keymap.set("n", "<leader>sm", function()
  local lines = vim.split(vim.fn.execute("messages"), "\n", { plain = true })
  vim.cmd("new")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.bo.modifiable = false
  vim.bo.buftype = "nofile"
end, { desc = "[S]how [M]essages" })

-- Auto-confirm plugin installation
local _pack_add = vim.pack.add
vim.pack.add = function(specs, opts)
  return _pack_add(specs, vim.tbl_extend("force", { confirm = false }, opts or {}))
end

vim.api.nvim_create_user_command("PackUpdate", function()
  vim.pack.update()
end, {})

-- Colorscheme
require("user.plugins.catppuccin")

-- Completion (lazydev → luasnip → blink, must be before LSP)
require("user.plugins.lazydev")
require("user.plugins.luasnip")
require("user.plugins.blink")

-- LSP (telescope must be before lsp — used in keymaps; mason before lsp — installs binaries)
require("user.plugins.telescope")
require("user.plugins.mason")
require("user.plugins.lsp")

-- Editor
require("user.plugins.treesitter")
require("user.plugins.mini-ai")
require("user.plugins.indent-blankline")
require("user.plugins.conform")
require("user.plugins.lint")

-- Git
require("user.plugins.gitsigns")

-- UI
require("user.plugins.lualine")
require("user.plugins.trouble")
require("user.plugins.which-key")
require("user.plugins.outline")
require("user.plugins.render-markdown")

-- Navigation & terminal
require("user.plugins.neo-tree")
require("user.plugins.toggleterm")

-- Misc
require("user.plugins.other")
