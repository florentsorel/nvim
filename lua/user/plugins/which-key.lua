vim.pack.add({ "https://github.com/folke/which-key.nvim" })

require("which-key").setup({
  icons = {
    mappings = vim.g.have_nerd_font,
  },
  spec = {
    { "<leader>c", group = "[C]ode",     mode = { "n", "x" } },
    { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
    { "<leader>s", group = "[S]earch" },
    { "<leader>t", group = "[T]oggle" },
    { "<leader>x", group = "Diagnostics" },
  },
})
