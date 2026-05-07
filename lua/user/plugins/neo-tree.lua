vim.pack.add({
  "https://github.com/nvim-neo-tree/neo-tree.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/MunifTanjim/nui.nvim",
})

require("neo-tree").setup({
  window = {
    position = "float",
    mappings = {
      ["\\"]   = "close_window",
      ["<C-x>"] = "open_split",
      ["<C-v>"] = "open_vsplit",
      ["<C-t>"] = "open_tabnew",
    },
  },
  filesystem = {
    filtered_items = {
      visible = false,
      hide_dotfiles = false,
      hide_gitignored = true,
    },
  },
})

vim.keymap.set("n", "\\", "<cmd>Neotree reveal<cr>", { desc = "NeoTree reveal", silent = true })
