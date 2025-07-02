return {
  "saghen/blink.cmp",
  event = "VimEnter",
  version = "1.*",
  dependencies = {
    "folke/lazydev.nvim",
  },
  opts = {
    keymap = {
      preset = "default",

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },

      ["<C-k>"] = { "show_documentation", "hide_documentation", "fallback" },

      ["<C-Up>"] = { "scroll_documentation_up", "fallback" },
      ["<C-Down>"] = { "scroll_documentation_down", "fallback" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },
    appearance = {
      nerd_font_variant = "mono",
    },
    completion = {
      documentation = { auto_show = false, auto_show_delay_ms = 100, window = { border = "rounded" } },
      keyword = { range = "prefix" },
      menu = {
        auto_show = true,
        border = "rounded",
        draw = {
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind", gap = 1 },
            { "source_name" },
          },
        },
      },
    },
    sources = {
      default = { "lsp", "path", "snippets", "lazydev" },
      providers = {
        lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true, window = { border = "rounded" } },
  },
}
