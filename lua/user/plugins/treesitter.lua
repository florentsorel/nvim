vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main", build = ":TSUpdate" },
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
})

require("nvim-treesitter").setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

require("nvim-treesitter").install({
  "bash",
  "c",
  "diff",
  "dockerfile",
  "go",
  "javascript",
  "json",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "odin",
  "query",
  "rust",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "vue",
})

-- Enable treesitter highlighting for all filetypes (silently skips if no parser)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

require("treesitter-context").setup({
  enable = true,
  multiline_threshold = 1,
  trim_scope = "outer",
  mode = "cursor",
})
