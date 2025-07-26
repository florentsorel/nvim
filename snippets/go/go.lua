local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s(
    "main",
    fmt(
      [[
package main

func main() {{
	{}
}}
]],
      { i(0) }
    )
  ),
  s(
    "ife",
    fmt(
      [[
if err != nil {{
	{}
}}
]],
      { i(0) }
    )
  ),
  s(
    "ie=",
    fmt(
      [[
        if err := {}; err != nil {{
        {}{}
        }}
      ]],
      { i(1), t "\t", i(0) }
    )
  ),
}
