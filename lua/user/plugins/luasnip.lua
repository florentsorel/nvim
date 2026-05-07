vim.pack.add({
  { src = "https://github.com/L3MON4D3/LuaSnip", version = "v2.5.0", build = "make install_jsregexp" },
})

require("luasnip.loaders.from_lua").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
