return {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        buildScripts = { enable = true },
      },
      procMacro = { enable = true },
      checkOnSave = true,
      check = {
        command = "clippy",
      },
      inlayHints = {
        chainingHints = { enable = true },
        typeHints = { enable = true },
        parameterHints = { enable = true },
        maxLength = 120,
      },
    },
  },
}
