vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local progress = function()
  local current_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")
  local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local index = math.ceil(current_line / total_lines * #chars)
  return chars[index]
end

require("lualine").setup({
  options = {
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "neo-tree" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {
      { "branch", icons_enabled = true, icon = "" },
      { "diagnostics", sources = { "nvim_diagnostic" }, sections = { "error", "warn" }, colored = false, always_visible = true },
    },
    lualine_b = { { "mode", fmt = function(str) return "-- " .. str .. " --" end } },
    lualine_c = {
      { "filename", path = 1, symbols = { modified = "●", readonly = "", unnamed = "[No Name]" } },
    },
    lualine_x = {
      { "diff", colored = false, symbols = { added = " ", modified = " ", removed = " " }, cond = hide_in_width },
      { function() return (vim.bo.expandtab and "space" or "tab") .. ": " .. vim.bo.shiftwidth end },
      "encoding",
      { "filetype", icons_enabled = false },
    },
    lualine_y = { { "location", padding = 0 } },
    lualine_z = { progress },
  },
  inactive_sections = {
    lualine_c = { "filename" },
    lualine_x = { "location" },
  },
})
