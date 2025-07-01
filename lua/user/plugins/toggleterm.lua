return {
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = "<Leader>\\",
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = false,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })

      local terminal = require("toggleterm.terminal").Terminal
      local lazygit = terminal:new({ cmd = "lazygit", hidden = true })
      function LAZYGIT_TOGGLE()
        lazygit:toggle()
      end

      vim.keymap.set("n", "<Leader>gg", "<Cmd>lua LAZYGIT_TOGGLE()<CR>", { desc = "Open lazygit" })
    end,
  },
}
