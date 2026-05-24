#!/usr/bin/env bash
set -euo pipefail

nvim_guide=docs/guides/04-neovim.md
tmux_guide=docs/guides/05-tmux.md
verification=docs/guides/99-verification.md
nvim_config=config/nvim/init.lua
nvim_shared=config/nvim/lua/terminal_first/init.lua
nvim_windows=config/nvim/lua/terminal_first/windows.lua
nvim_ubuntu=config/nvim/lua/terminal_first/ubuntu.lua
tmux_config=config/tmux/tmux.conf

for path in "$nvim_guide" "$tmux_guide" "$verification" "$nvim_config" "$nvim_shared" "$nvim_windows" "$nvim_ubuntu" "$tmux_config"; do
  test -f "$path" || {
    echo "missing required file: $path" >&2
    exit 1
  }
done

grep -q 'Windows PowerShell' "$nvim_guide"
grep -q 'Ubuntu' "$nvim_guide"
grep -q 'nvim --version' "$nvim_guide"
grep -q 'nvim --clean' "$nvim_guide"
grep -q 'Lazy' "$nvim_guide"
grep -q ':checkhealth' "$nvim_guide"
grep -q 'shared source config' "$nvim_guide"
grep -q 'thin OS-specific adapters' "$nvim_guide"
grep -q 'plugin/runtime state must not be shared through a Windows-mounted path' "$nvim_guide"
grep -q 'Lua' "$nvim_guide"
grep -q 'Markdown' "$nvim_guide"
grep -q 'Shell' "$nvim_guide"
grep -q 'PowerShell' "$nvim_guide"
grep -q 'JavaScript/TypeScript' "$nvim_guide"
grep -q 'Python' "$nvim_guide"
grep -q 'optional profile' "$nvim_guide"

grep -q 'terminal-first shared Neovim config' "$nvim_config"
grep -q 'terminal_first' "$nvim_config"
grep -q 'nvim-treesitter' "$nvim_shared"
grep -q 'nvim-lspconfig' "$nvim_shared"
grep -q 'conform.nvim' "$nvim_shared"
grep -q 'nvim-lint' "$nvim_shared"
grep -q 'telescope.nvim' "$nvim_shared"
grep -q 'lua_ls' "$nvim_shared"
grep -q 'marksman' "$nvim_shared"
grep -q 'bashls' "$nvim_shared"
grep -q 'powershell_es' "$nvim_shared"
grep -q 'optional_languages' "$nvim_shared"
grep -q 'typescript' "$nvim_shared"
grep -q 'python' "$nvim_shared"

grep -q 'tmux -V' "$tmux_guide"
grep -q 'tmux -f' "$tmux_guide"
grep -q 'Ubuntu only' "$tmux_guide"
grep -q 'Native Windows tmux support is outside the first slice' "$tmux_guide"
grep -q 'prefix' "$tmux_guide"
grep -q 'pane' "$tmux_guide"
grep -q 'window' "$tmux_guide"
grep -q 'mouse' "$tmux_guide"
grep -q 'status' "$tmux_guide"
grep -q 'copy-mode' "$tmux_guide"

grep -q 'prefix C-a' "$tmux_config"
grep -q 'set -g mouse on' "$tmux_config"
grep -q 'split-window -h' "$tmux_config"
grep -q 'split-window -v' "$tmux_config"
grep -q 'copy-mode-vi' "$tmux_config"
grep -q 'status-left' "$tmux_config"

grep -q 'Neovim Windows' "$verification"
grep -q 'Neovim Ubuntu' "$verification"
grep -q 'tmux Ubuntu' "$verification"
grep -q 'nvim --version' "$verification"
grep -q ':checkhealth' "$verification"
grep -q 'tmux -V' "$verification"
grep -q 'tmux -f' "$verification"

if grep -Rqi 'supports native Windows tmux\\|tmux works natively on Windows' README.md docs/guides docs/troubleshooting; then
  echo "native Windows tmux support must not be claimed" >&2
  exit 1
fi
