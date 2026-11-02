vim.pack.add({
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/igorlfs/nvim-dap-view",
  "https://github.com/jay-babu/mason-nvim-dap.nvim",
  "https://github.com/mason-org/mason.nvim",
})

local dap = require("dap")

-- Adapters (codelldb, delve, debugpy) are installed and registered through mason.
require("mason-nvim-dap").setup({
  ensure_installed = { "codelldb", "delve", "python" },
  automatic_installation = true,
  handlers = {}, -- default handler: register every installed adapter
})

-- Single-window debug UI (scopes, watches, breakpoints, threads, REPL as tabs),
-- opened/closed automatically with the debug session.
require("dap-view").setup({ auto_toggle = true })

-- Build, then ask which binary to run (remembers the last answer per command).
local last_program = {}
local function build_then_pick(build_cmd, default)
  return function()
    if build_cmd then
      local out = vim.fn.system(build_cmd)
      if vim.v.shell_error ~= 0 then
        vim.notify("Build failed:\n" .. out, vim.log.levels.ERROR)
        return dap.ABORT
      end
    end
    local key = build_cmd or default
    local path = vim.fn.input("Binary: ", last_program[key] or default, "file")
    last_program[key] = path
    return path
  end
end

local function lldb_config(name, build_cmd, default)
  return {
    name = name,
    type = "codelldb",
    request = "launch",
    program = build_then_pick(build_cmd, default),
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  }
end

-- Defined after mason-nvim-dap so they override its generic defaults.
dap.configurations.odin = {
  lldb_config("Odin: build + debug", "mkdir -p build && odin build . -debug -out:build/debug", "build/debug"),
}
-- C/C++: always build first, so F5 never runs a stale binary.
--   * Makefile present        -> `make`
--   * CMakeLists.txt present  -> configure in build/ (Debug) then `cmake --build`
--   * neither                 -> compile the current file with debug symbols to build/debug
-- Then the executable is looked up in build/ (asks only if there are several or none).
local function find_executables(dir)
  local found = {}
  local files = vim.fs.find(function(name, path)
    return not path:find("CMakeFiles", 1, true)
      and not name:match("%.o$")
      and not name:match("%.a$")
      and not name:match("%.so[%.%d]*$")
      and not name:match("%.dylib$")
      and not name:match("%.dSYM$")
  end, { path = dir, type = "file", limit = math.huge })
  for _, f in ipairs(files) do
    if vim.fn.executable(f) == 1 then
      table.insert(found, f)
    end
  end
  return found
end

local function run(cmd)
  local out = vim.fn.system(cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify("Build failed (" .. table.concat(cmd, " ") .. "):\n" .. out, vim.log.levels.ERROR)
    return false
  end
  return true
end

local function c_program()
  local cwd = vim.fn.getcwd()
  local src = vim.api.nvim_buf_get_name(0)
  local cc = vim.bo.filetype == "cpp" and "clang++" or "clang"

  local function exists(name)
    return vim.uv.fs_stat(cwd .. "/" .. name) ~= nil
  end

  if exists("Makefile") or exists("makefile") or exists("GNUmakefile") then
    if not run({ "make" }) then
      return dap.ABORT
    end
  elseif exists("CMakeLists.txt") then
    if
      not run({ "cmake", "-B", "build", "-DCMAKE_BUILD_TYPE=Debug", "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" })
      or not run({ "cmake", "--build", "build" })
    then
      return dap.ABORT
    end
  else
    vim.fn.mkdir(cwd .. "/build", "p")
    if not run({ cc, "-g", "-O0", "-o", "build/debug", src }) then
      return dap.ABORT
    end
    return cwd .. "/build/debug"
  end

  local candidates = find_executables(cwd .. "/build")
  if #candidates == 1 then
    return candidates[1]
  end
  return vim.fn.input("Binary: ", cwd .. "/build/", "file")
end

dap.configurations.c = {
  {
    name = "C: build + debug",
    type = "codelldb",
    request = "launch",
    program = c_program,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}
dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = {
  lldb_config("Rust: cargo build + debug", "cargo build", "target/debug/"),
}

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "CursorLine" })

-- Keymaps (F-keys like an IDE, plus <leader>d prefix)
local map = vim.keymap.set
map("n", "<F5>", dap.continue, { desc = "Debug: start/continue" })
map("n", "<F10>", dap.step_over, { desc = "Debug: step over" })
map("n", "<F11>", dap.step_into, { desc = "Debug: step into" })
map("n", "<F12>", dap.step_out, { desc = "Debug: step out" })
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "[D]ebug: toggle [B]reakpoint" })
map("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Condition: "))
end, { desc = "[D]ebug: conditional [B]reakpoint" })
map("n", "<leader>dc", dap.continue, { desc = "[D]ebug: [C]ontinue / start" })
map("n", "<leader>dn", dap.step_over, { desc = "[D]ebug: [N]ext (step over)" })
map("n", "<leader>ds", dap.step_into, { desc = "[D]ebug: [S]tep into" })
map("n", "<leader>do", dap.step_out, { desc = "[D]ebug: step [O]ut" })
map("n", "<leader>dr", dap.restart, { desc = "[D]ebug: [R]estart" })
map("n", "<leader>dq", dap.terminate, { desc = "[D]ebug: [Q]uit session" })
map("n", "<leader>dv", "<cmd>DapViewToggle<cr>", { desc = "[D]ebug: toggle [V]iew" })
map({ "n", "v" }, "<leader>de", function()
  require("dap.ui.widgets").hover()
end, { desc = "[D]ebug: [E]val under cursor" })
