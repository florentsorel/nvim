return {
  { "folke/todo-comments.nvim", event = "VimEnter", dependencies = { "nvim-lua/plenary.nvim" }, opts = { signs = false } },
  {
    "arnamak/stay-centered.nvim",
    keys = {
      { "<leader>st", '<cmd>lua require("stay-centered").toggle()<CR>', desc = "Enable / Disabled centered mode" },
    },
  },
  { "github/copilot.vim" },
}
