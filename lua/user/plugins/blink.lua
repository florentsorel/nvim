vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp", build = "cargo build --release" },
})

require("blink.cmp").setup({
  keymap = {
    preset = "default",
    ["<C-k>"] = { "show_documentation", "hide_documentation", "fallback" },
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
  },
  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 100,
      window = { border = "rounded" },
    },
    menu = {
      border = "rounded",
      draw = {
        columns = {
          { "label", "label_description", gap = 1 },
          { "kind_icon", "kind", gap = 1 },
        },
      },
    },
  },
  snippets = { preset = "luasnip" },
  sources = {
    default = { "lsp", "path", "snippets", "buffer", "lazydev" },
    providers = {
      lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
    },
  },
  fuzzy = { implementation = "prefer_rust" },
  signature = { enabled = true, window = { border = "rounded" } },
})
