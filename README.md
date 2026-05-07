# nvim-next

Neovim 0.12+ configuration.

## Requirements

### Neovim

- Neovim >= 0.12

### System dependencies

| Tool | Used by | Install |
|------|---------|---------|
| `tree-sitter-cli` | tree-sitter-manager (parser compilation) | `brew install tree-sitter-cli` |
| `cargo` / Rust | blink.cmp (fuzzy matching binary) | [rustup](https://rustup.rs) |
| `fd` | telescope (find_files) | `brew install fd` |
| `ripgrep` | telescope (live_grep, grep_string) | `brew install ripgrep` |
| `npm` | mason (LSP servers, linters, formatters) | `brew install node` or [volta](https://volta.sh) |
| `make` | telescope-fzf-native | `brew install make` |
| `git` | vim.pack (plugin manager) | `brew install git` |

### Optional

| Tool | Used by | Install |
|------|---------|---------|
| A Nerd Font | icons in lualine, telescope, etc. | <https://www.nerdfonts.com> |
