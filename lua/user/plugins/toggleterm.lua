vim.pack.add({ "https://github.com/akinsho/toggleterm.nvim" })

require("toggleterm").setup({
  size = 20,
  open_mapping = [[<Leader>\]],
  hide_numbers = true,
  start_in_insert = true,
  insert_mappings = false,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  float_opts = {
    border = "curved",
  },
})

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

vim.keymap.set("n", "<leader>gg", function()
  lazygit:toggle()
end, { desc = "Open lazygit" })
