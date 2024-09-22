return {
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  "catppuccin/nvim",
  priority = 1000,
  init = function()
    vim.cmd.colorscheme "catppuccin-mocha"

    -- You can configure highlights by doing something like:
    vim.cmd.hi "Comment gui=none"
  end,
}
