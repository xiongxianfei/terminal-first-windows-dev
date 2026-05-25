# Terminal-First Windows Dev

<!-- vision:start -->
This is a concise developer setup guide for building a terminal-first Windows 11 development environment.

It differs from broad Windows setup guides and personal bootstrap projects by choosing a short, opinionated path over exhaustive coverage or opaque automation.

It is for developers who use Windows 11 as their primary or regular workstation and want the terminal to be the center of daily development.

See [VISION.md](VISION.md) for goals, non-goals, and falsifiability.
<!-- vision:end -->

This repository is a verification-first playbook for setting up a practical Windows 11 workstation centered on Windows Terminal, PowerShell, WSL2 Ubuntu, Neovim, and tmux.

It is not a one-command unattended installer. Commands and configuration changes should be readable before they are run, especially when they affect administrator permissions, WSL storage, proxy behavior, sudoers, fstab, or editor configuration.

## Setup Path

Follow the guides in order:

1. [Windows host](docs/guides/01-windows-host.md): Windows Terminal, PowerShell, package tooling, and host checks.
2. [WSL2 Ubuntu](docs/guides/02-wsl2-ubuntu.md): explicit Ubuntu LTS selection, D-drive WSL storage, migration path, and verification.
3. [Ubuntu baseline](docs/guides/03-ubuntu-baseline.md): proxy posture, data mount, locale, sudo profile, and Linux-side checks.
4. [Neovim](docs/guides/04-neovim.md): Windows and Ubuntu editor setup with one concise shared config file.
5. [tmux](docs/guides/05-tmux.md): Ubuntu tmux setup for daily terminal work.
6. [Verification](docs/guides/99-verification.md): consolidated checks and result vocabulary.

## Warning Labels

- Administrator-sensitive: may require elevation or be blocked by enterprise policy.
- Destructive: can remove or overwrite local state if preconditions are skipped.
- Machine-wide: affects WSL or operating-system behavior outside one shell session.
- User-local: affects files in the current user's profile or home directory.
- Manual verification: must be checked on a Windows 11 or WSL machine; this repository cannot prove it from static docs alone.

## Scope

The first slice targets Windows 11, Windows Terminal, latest stable PowerShell, WSL2 Ubuntu, Neovim on Windows and Ubuntu, and tmux on Ubuntu.

It does not cover older Windows versions, arbitrary WSL storage roots, full corporate PAC or custom CA setup, language runtimes, Docker, databases, cloud tools, native Windows tmux, or a full dotfiles framework.

## Troubleshooting

- [Enterprise policy](docs/troubleshooting/enterprise-policy.md)
- [Proxy limits](docs/troubleshooting/proxy.md)
- [Ubuntu baseline](docs/troubleshooting/ubuntu-baseline.md)
- [WSL command/version drift](docs/troubleshooting/wsl.md)

## Project Workflow

Project decisions are recorded in specs, architecture notes, ADRs, plans, tests, and review artifacts before implementation. Start with [CONSTITUTION.md](CONSTITUTION.md), [VISION.md](VISION.md), and [docs/workflows.md](docs/workflows.md) when contributing.
