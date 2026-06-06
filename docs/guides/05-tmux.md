# tmux Setup

## Purpose

Provide a minimal tmux setup for daily terminal development inside Ubuntu on WSL.

## Command environment

- Ubuntu shell: tmux install and version checks.
- tmux command: session, pane, window, copy-mode, and config-load checks.
- Manual verification: terminal behavior and keybinding checks.

## Safety notes

- tmux support is Ubuntu only in this first slice.
- Native Windows tmux support is outside the first slice.
- tmux configuration writes affect user-local config files.
- The current tmux config does not use tmux plugins or a plugin manager.
- This project is not a one-command unattended installer.

## Install tmux

Install tmux inside Ubuntu:

```bash
sudo apt update
sudo apt install -y tmux
```

Verify the installed version:

```bash
tmux -V
```

## Config strategy

The example config lives at `config/tmux/tmux.conf`. Install it as the user's Ubuntu tmux config:

```bash
cp config/tmux/tmux.conf ~/.tmux.conf
```

Back up an existing `~/.tmux.conf` before replacing it.

## Daily-use baseline

The config covers:

- prefix: tmux default `C-b`;
- pane split keys: `|` for horizontal and `-` for vertical;
- pane movement: `h`, `j`, `k`, and `l`;
- window indexing from 1 and automatic renumbering;
- mouse support;
- status bar with session and time;
- copy-mode using vi keys.
- no tmux plugins.

## Quick start

Start a named session:

```bash
tmux new -s dev
```

Detach and leave the session running:

```text
prefix d
```

List sessions:

```bash
tmux ls
```

Attach again:

```bash
tmux attach -t dev
```

Common keys:

| Action | Key |
| --- | --- |
| Prefix | `C-b` |
| Split left/right | `prefix |` |
| Split top/bottom | `prefix -` |
| New window | `prefix c` |
| Next window | `prefix n` |
| Previous window | `prefix p` |
| Copy mode | `prefix [` |
| Detach | `prefix d` |

Inside copy mode, use vi-style movement, `v` to start selection, and `y` or `Enter` to copy.

## Verification

Run:

```bash
tmux -V
```

Load the config in a clean disposable session:

```bash
tmux -f config/tmux/tmux.conf new-session -d -s terminal-first-check
tmux kill-session -t terminal-first-check
```

Manual checks:

- prefix `C-b` sends tmux commands;
- pane splits work with `prefix |` and `prefix -`;
- windows start at index 1;
- mouse selection and pane focus work in Windows Terminal;
- copy-mode opens and uses vi-style selection.

## Validation

- tmux is scoped to Ubuntu only.
- The guide does not claim native Windows tmux support.
- The config covers prefix, panes, windows, mouse, status, and copy-mode behavior.
- Verification includes `tmux -V` and loading the configuration in a clean session.

## Rollback

Restore the backed-up `~/.tmux.conf` or remove the project-owned tmux config file. Kill only tmux sessions that were created for verification unless the user intentionally wants to reset active sessions.
