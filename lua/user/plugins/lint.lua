vim.pack.add({ "https://github.com/mfussenegger/nvim-lint" })

local lint = require("lint")

lint.linters_by_ft = {
  dockerfile = { "hadolint" },
  go = { "golangcilint" },
  json = { "jsonlint" },
  sh = { "shellcheck" },
  yaml = { "yamllint" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("lint", { clear = true }),
  callback = function()
    if vim.o.buftype == "" then
      lint.try_lint()
    end
  end,
})
