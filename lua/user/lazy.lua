local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  require "user.plugins.toggleterm",
  require "user.plugins.colorscheme",

  require "user.plugins.neo-tree",
  require "user.plugins.autopair",
  require "user.plugins.lualine",
  require "user.plugins.indent_blankline",
  require "user.plugins.gitsigns",
  require "user.plugins.outline",

  require "user.plugins.telescope",
  require "user.plugins.treesitter",
  require "user.plugins.lsp",
  require "user.plugins.lint",
  require "user.plugins.autocompletion",
  require "user.plugins.snippet",
  require "user.plugins.lazydev",
  require "user.plugins.trouble",
  require "user.plugins.conform",
  require "user.plugins.markdown",

  require "user.plugins.other",

  require "user.plugins.which_key",
}, {
  change_detection = {
    enabled = false,
    notify = false,
  },
  ui = {
    border = "rounded",
    size = {
      width = 0.8,
      height = 0.8,
    },
    icons = vim.g.have_nerd_font and {},
  },
})
