vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

require("conform").setup({
  notify_on_error = false,
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    c = { "clang-format" },
    cpp = { "clang-format" },
    cs = { "csharpier" },
    css = { "prettier" },
    go = { "goimports", "gofumpt" },
    html = { "prettier" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    json = { "prettier" },
    lua = { "stylua" },
    sh = { "shfmt" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    vue = { "prettier" },
    yaml = { "prettier" },
  },
  formatters = {
    ["clang-format"] = {
      prepend_args = { "-style={BasedOnStyle: Chromium, SeparateDefinitionBlocks: Always, EmptyLineBeforeAccessModifier: LogicalBlock, DerivePointerAlignment: false, PointerAlignment: Right, AllowShortIfStatementsOnASingleLine: WithoutElse, IndentWidth: 4, AccessModifierOffset: -4}" },
    },
  },
})

vim.keymap.set({ "n", "v" }, "<leader>f", function()
  require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "[F]ormat buffer" })
