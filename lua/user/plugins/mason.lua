vim.pack.add({
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  "https://github.com/neovim/nvim-lspconfig",
})

require("mason").setup({
  ui = { border = "rounded" },
})

require("mason-lspconfig").setup({
  automatic_installation = true,
  ensure_installed = {
    "bashls",
    "clangd",
    "docker_compose_language_service",
    "dockerls",
    "eslint",
    "gopls",
    "lua_ls",
    "ols",
    "rust_analyzer",
    "ts_ls",
    "vuels",
    "yamlls",
  },
})

require("mason-tool-installer").setup({
  ensure_installed = {
    -- Formatters
    "clang-format",
    "gofumpt",
    "goimports",
    "prettier",
    "shfmt",
    "stylua",

    -- Linters
    "golangci-lint",
    "hadolint",
    "jsonlint",
    "shellcheck",
    "yamllint",
  },
})
