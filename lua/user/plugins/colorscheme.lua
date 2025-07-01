return {
  "catppuccin/nvim",
  priority = 1000,
  init = function()
    require("catppuccin").setup({
      transparent_background = true,
      integrations = {
        neotree = true,
        mason = true,
        nvim_surround = true,
        which_key = true,
      },
    })
    vim.cmd.colorscheme "catppuccin-mocha"

    vim.cmd.hi "Comment gui=none"
  end,
}
