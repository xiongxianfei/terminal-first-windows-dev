# Neovim Setup

## Purpose

Provide a minimal Neovim setup for Windows PowerShell and Ubuntu without turning this repository into a full editor distribution.

## Command environment

- Windows PowerShell: Windows Neovim install and verification.
- Ubuntu shell: Ubuntu Neovim install and verification.
- Neovim command: startup checks, plugin manager checks, and `:checkhealth` troubleshooting.

## Safety notes

- Neovim configuration writes affect user-local config directories.
- Use one shared source config with thin OS-specific adapters.
- plugin/runtime state must not be shared through a Windows-mounted path.
- Optional language profiles must stay optional.
- This project is not a one-command unattended installer.

## Install Neovim

Install the latest stable Neovim package through the package path approved for each environment.

Windows PowerShell example:

```powershell
winget install --id Neovim.Neovim --source winget
```

Ubuntu example:

```bash
sudo apt update
sudo apt install -y neovim
```

If the Ubuntu package is older than the user's needs, use an official Neovim release channel and record the source in verification notes.

## Config strategy

The source config lives in this repository under `config/nvim/`:

- `config/nvim/init.lua`: terminal-first shared Neovim config entry point.
- `config/nvim/lua/terminal_first/init.lua`: shared source config and plugin profile.
- `config/nvim/lua/terminal_first/windows.lua`: thin Windows adapter.
- `config/nvim/lua/terminal_first/ubuntu.lua`: thin Ubuntu adapter.

Deploy or sync the same source config separately into each environment:

- Windows target: `%LocalAppData%\nvim`
- Ubuntu target: `~/.config/nvim`

Do not put plugin/runtime state on `D:\Data`, `/home/<user>/data`, or another Windows-mounted path. Let each environment keep its own plugin cache and runtime state.

## Language profile

Core profile:

- Lua: `lua_ls`, `stylua`.
- Markdown: `marksman`, `markdownlint`, `prettier`.
- Shell: `bashls`, `shellcheck`, `shfmt`.
- PowerShell: `powershell_es`.

Optional profile:

- JavaScript/TypeScript: optional profile using TypeScript, ESLint, and Prettier tools when installed.
- Python: optional profile using Pyright and Ruff tools when installed.

The config records these as `core_languages` and `optional_languages`. Installing language servers, formatters, and linters is outside the broad runtime setup scope for this first slice; missing tools should be reported clearly by Neovim health checks or future doctor checks.

## Plugin baseline

The minimal plugin baseline is:

- `nvim-treesitter/nvim-treesitter` for syntax support.
- `neovim/nvim-lspconfig` for LSP diagnostics.
- `stevearc/conform.nvim` for formatting integration.
- `mfussenegger/nvim-lint` for linting integration.
- `nvim-telescope/telescope.nvim` for file and text navigation.

Use a plugin manager such as Lazy to install those plugins in each environment. Keep plugin manager lockfiles environment-local or intentionally copied; do not share plugin/runtime state through a Windows-mounted path.

## Verification

Run separately in Windows PowerShell and Ubuntu:

```powershell
nvim --version
```

```bash
nvim --version
```

Check startup without user config errors:

```bash
nvim --clean +'quit'
```

After deploying this config, check plugin manager status with the installed plugin manager. For Lazy, use the Neovim command:

```vim
:Lazy
```

Run health checks:

```vim
:checkhealth
```

Expected result:

- Windows and Ubuntu each report `nvim --version`.
- Neovim starts without config errors.
- Plugin manager status shows the baseline plugins installed or clearly reports missing installation steps.
- `:checkhealth` identifies missing language tools without blocking unrelated editor startup.

## Validation

- The guide documents Neovim for both Windows PowerShell and Ubuntu.
- The config uses one shared source config with thin OS-specific adapters.
- Plugin/runtime state is not shared through a Windows-mounted path.
- The core profile covers Lua, Markdown, Shell, and PowerShell where supported by available tools.
- JavaScript/TypeScript and Python are optional profiles.
- Verification includes `nvim --version`, startup without config errors, plugin manager status, and `:checkhealth`.

## Rollback

- Windows: restore the backed-up `%LocalAppData%\nvim` directory or remove the project-owned files.
- Ubuntu: restore the backed-up `~/.config/nvim` directory or remove the project-owned files.
- Remove environment-local plugin manager cache or lockfiles only after confirming no wanted editor state is inside.
