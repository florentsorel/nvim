vim.pack.add({
  "https://github.com/folke/todo-comments.nvim",
  "https://github.com/tpope/vim-sleuth",
  "https://github.com/github/copilot.vim",
  "https://github.com/arnamak/stay-centered.nvim",
})

require("todo-comments").setup({ signs = false })
require("stay-centered").setup()

vim.keymap.set("n", "<leader>st", function()
  require("stay-centered").toggle()
end, { desc = "[S]tay centered [T]oggle" })
