return {
  "folke/trouble.nvim",
  opts = {},
  cmd = "Trouble",
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Toggle buffer diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Toggle diagnostics (Trouble)",
    },
    {
      "[d",
      function()
        vim.diagnostic.jump({ count = -1, float = true })
      end,
      desc = "Go to previous [D]iagnostic message",
    },
    {
      "]d",
      function()
        vim.diagnostic.jump({ count = 1, float = true })
      end,
      desc = "Go to next [D]iagnostic message",
    },
    {
      "<leader>q",
      function()
        vim.diagnostic.setloclist()
      end,
      desc = "Open diagnotic [Q]uickfix list",
    },
  },
}
