vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp" },
})

-- vim.pack doesn't run build steps; compile the Rust fuzzy matcher on install/update.
vim.api.nvim_create_autocmd("PackChanged", {
  desc = "Build blink.cmp fuzzy matcher",
  callback = function(args)
    if args.data.spec.name ~= "blink.cmp" or args.data.kind == "delete" then
      return
    end
    vim.notify("blink.cmp: building fuzzy matcher...", vim.log.levels.INFO)
    vim.system({ "cargo", "build", "--release" }, { cwd = args.data.path }, function(out)
      local level = out.code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR
      local msg = out.code == 0 and "blink.cmp: build complete" or ("blink.cmp build failed:\n" .. (out.stderr or ""))
      vim.schedule(function() vim.notify(msg, level) end)
    end)
  end,
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
