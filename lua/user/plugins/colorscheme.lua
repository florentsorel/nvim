return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false, -- we load this during startup if it is the main colorscheme
  priority = 1000, -- load this before all the other start plugins
  config = function()
    vim.cmd.colorscheme "catppuccin-mocha"
  end,
}
