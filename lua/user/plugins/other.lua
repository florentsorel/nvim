-- Tab belongs to blink.cmp (super-tab); accept Copilot suggestions with <C-y> instead.
-- Must be set before copilot.vim is sourced.
vim.g.copilot_no_tab_map = true

vim.pack.add({
  "https://github.com/folke/todo-comments.nvim",
  "https://github.com/tpope/vim-sleuth",
  "https://github.com/github/copilot.vim",
  "https://github.com/arnamak/stay-centered.nvim",
})

require("todo-comments").setup({ signs = false })
require("stay-centered").setup()

vim.keymap.set("i", "<C-y>", 'copilot#Accept("")', {
  expr = true,
  replace_keycodes = false,
  desc = "Copilot accept suggestion",
})

vim.keymap.set("n", "<leader>st", function()
  require("stay-centered").toggle()
end, { desc = "[S]tay centered [T]oggle" })
