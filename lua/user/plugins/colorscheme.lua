return {
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  "catppuccin/nvim",
  priority = 1000,
  init = function()
    vim.cmd.colorscheme "catppuccin-mocha"
    require("catppuccin").setup({
      transparent_background = true,
      integrations = {
        neotree = true,
        mason = true,
        nvim_surround = true,
        which_key = true,
      },
    })

    -- You can configure highlights by doing something like:
    vim.cmd.hi "Comment gui=none"
  end,
}
