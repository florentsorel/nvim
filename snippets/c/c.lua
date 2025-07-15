local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node

return {
  s("main", {
    t({
      "#include <stdio.h>",
      "",
      "int main(void) {",
      '    printf("Hello, world!\\n");',
      "    return 0;",
      "}",
    }),
  }),
}
