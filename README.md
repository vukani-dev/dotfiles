# NixOS Configuration

A NixOS configuration for managing multiple machines

## Overview

This configuration manages multiple NixOS machines with shared base configuration and machine-specific customizations. It uses a modular approach with the following key components:

- Compositor: Hyprland (Wayland) / dwm (X11)
- Terminal: ghostty
- Shell: zsh with starship prompt, fzf
- Editor: Neovim (with specialized configurations for different languages)
- File Manager: yazi
- Browser: Zen Browser
- Bar: Waybar (Doom One theme)
- Launcher: rofi

## Machines

- **Necessary**: Microsoft Surface Laptop 4 (Intel Tiger Lake, Iris Xe) — Hyprland
- **Marga**: Dell Precision 5560 (Intel + NVIDIA) — dwm / Hyprland
- **Dala**: System76 Lemur
- **Monk**: Lenovo ThinkPad X220

## Hyprland Keybinds (Mod = Super)

### Window Management

| Keybind | Action |
|---------|--------|
| `Mod + h/j/k/l` | Focus window left/down/up/right |
| `Mod + Shift + h/j/k/l` | Move window |
| `Mod + Ctrl + h/j/k/l` | Resize window |
| `Mod + Shift + Return` | Open terminal (ghostty) |
| `Mod + Shift + c` | Kill focused window |
| `Mod + Shift + q` | Exit Hyprland |
| `Mod + Shift + Space` | Toggle floating |
| `Mod + Shift + f` | Fullscreen |
| `Mod + Space` | Toggle split |
| `Mod + m` | Monocle (maximize) |
| `Mod + b` | Toggle waybar |
| `Mod + Shift + t` | Toggle transparency |
| `Alt + Tab` | Cycle windows |
| `Mod + grave` | Toggle scratchpad |

### Workspaces

| Keybind | Action |
|---------|--------|
| `Mod + 1-9` | Switch to workspace 1-9 |
| `Mod + Shift + 1-9` | Move window to workspace 1-9 |
| 3-finger horizontal swipe | Switch workspace |

### Applications

| Keybind | Action |
|---------|--------|
| `Mod + r` | Application launcher (rofi) |
| `Mod + w` | Browser (Zen) |
| `Mod + d` | Discord (vesktop) |
| `Mod + e` | Email (thunderbird) |
| `Mod + p` | Password manager (bitwarden) |
| `Mod + n` | Notes (logseq) |

### Utilities

| Keybind | Action |
|---------|--------|
| `Mod + y` | File manager (yazi) |
| `Mod + s` | Audio mixer (pulsemixer) |
| `Mod + i` | Network manager (nmtui) |
| `Mod + q` | System monitor (gotop) |
| `Mod + c` | Toggle syncthing |
| `Mod + Shift + s` | Screenshot (region) |
| `Print` | Screenshot (full) |
| `Mod + Shift + b` | Bluetooth manager |
| `Mod + Shift + x` | Lock screen (hyprlock) |

### Media Keys

| Key | Action |
|-----|--------|
| `Brightness Up/Down` | Adjust brightness 5% |
| `Volume Up/Down` | Adjust volume 5% |
| `Mute` | Toggle mute |

### Mouse

| Action | Result |
|--------|--------|
| `Mod + Left Click` | Move window |
| `Mod + Right Click` | Resize window |

## Yazi Keybinds

| Key | Action |
|-----|--------|
| `W` | Set hovered image as wallpaper |
| `H` | Go to home directory |
| `C` | Go to dotfiles |
| `m` | Go to /mnt |

## Shell Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `rb` | `nh os switch ~/.dotfiles/` | Rebuild NixOS |
| `up` | `nh os switch ~/.dotfiles/ -u` | Update and rebuild |
| `bup` | `nix flake update nixpkgs-bleeding` | Update bleeding edge packages |
| `lg` | `lazygit` | Git TUI |
| `v` | `nvim .` | Open neovim in current dir |
| `jl` | `journal.sh` | Zen journal (ghostty + nvim, light theme) |
| `oc` | `ssh 10.1.0.100` | SSH into OpenClaw instance |
| `ask` | `ask.sh` | Prompt local LLM (qwen3:14b via Ollama) |
| `beetle` | `ask.sh` (dolphin3) | Prompt Beetle (uncensored) |
| `chat` | `oterm` | Ollama TUI with model switching |
| `ll` | `ls -l` | Long listing |
| `la` | `ls -a` | Show hidden files |

### LLM Usage

```bash
ask "what is the capital of france"       # one-shot prompt to qwen3:14b
cat main.py | ask "explain this code"     # pipe context
beetle "tell me something wild"           # use dolphin3 (uncensored)
chat                                       # interactive TUI (oterm)
ollama run qwen3:14b                      # interactive CLI chat
```

## Journal

`jl` opens a dedicated zen writing environment:
- Spawns a separate ghostty window with warm light theme and generous padding
- Opens the current year's journal file (`/mnt/vault/documents/life-log/YYYY.md`)
- Auto-jumps to end of file
- `,n` inserts a new `#MMDD` date header
- `,w` quick saves
- Spell check enabled, all editor chrome hidden

## Wallpaper System

- Daily rotation through `~/pictures/wallpapers/` using day-of-year cycling
- Complementary color extraction via ImageMagick (HSL hue shift +150 degrees)
- Centered with proportional margins (~3.2% of screen width)
- Auto-detects monitor resolution (works for laptop and external displays)
- Press `W` in yazi on any image to set it as wallpaper immediately

## Necessary-Specific Features

- **Kanshi**: Automatic monitor switching (docked: MateView at 3000x2000, undocked: laptop eDP-1)
- **Hibernate**: s2idle is broken on Tiger Lake — uses direct hibernate after 30 min idle (on battery only)
- **auto-cpufreq**: powersave on battery, performance on AC
- **Touchpad**: tap-to-click, drag lock, natural scroll, disable while typing
- **Sleep/wake kernel fixes**: `i915.enable_psr=0`, `i915.enable_dc=1`, `iwlwifi.power_save=0`

## Local LLM Infrastructure

- **Ollama server** at `10.1.0.113:11434` (LXC container on Proxmox, RTX 2080 Ti 11GB)
- **Models**: qwen3:14b (best quality), qwen3:8b, dolphin3 (uncensored), beetle (custom personality)
- **Open WebUI** at `10.1.0.114:8080`
- **OpenClaw gateway** at `10.1.0.100` with Soroveya (Claude) and Beetle (local) agents
- `OLLAMA_HOST` set globally so all tools auto-connect

## Key Features

### System Configuration
- Flake-based configuration
- Home Manager integration
- Automated garbage collection (weekly, 14 day retention)
- Hardware-specific optimizations
- Syncthing file synchronization
- Mullvad VPN support

### Desktop Environment (Hyprland)
- Waybar with Doom One theme, Nerd Font icons, calendar tooltip
- rofi launcher with Doom One colors
- swaybg wallpaper with ImageMagick compositing
- hyprlock / hypridle for lock and idle management
- 3-finger swipe gestures for workspace switching
- Blur and transparency controls

### Performance
- zram swap compression
- earlyoom (prevents OOM freezes)
- fstrim for SSDs
- Gamemode for gaming
- Hibernate support with resume from swap

### Development Tools
- Multiple Neovim configurations (Rust, Python, Web, IaC)
- Git integration (lazygit)
- Docker support
- Claude Code, Codex, Gemini CLI

## Structure

```
~/.dotfiles/
├── flake.nix              # Main entry point
├── flake.lock             # Dependency lock
├── global-config.nix      # Shared system config
├── machines/              # Machine-specific configs
│   ├── marga/
│   ├── necessary/
│   ├── dala/
│   └── monk/
├── modules/               # System modules
│   ├── hyprland/          # Hyprland + waybar config
│   ├── suckless/          # dwm & st configs
│   ├── displays/          # Per-machine display configs
│   ├── gaming.nix
│   ├── docker.nix
│   ├── syncthing.nix
│   └── ...
└── home-manager/          # User environment
    ├── home.nix
    ├── modules/           # User modules (zsh, yazi, rofi, zen-browser)
    ├── scripts/           # Shell scripts (wallpaper, journal, ask)
    └── assets/            # Wallpaper collection
```

## Installation

1. Clone this repository:

```bash
git clone https://github.com/vukani-dev/dotfiles ~/.dotfiles
```

2. Update the hostname in the appropriate machine configuration under `machines/`

3. Build and switch to the configuration:

```bash
nh os switch ~/.dotfiles -H <hostname>
```

## License

GNU General Public License v3.0

## Credits

- dwm configuration based on [vukani-dev/dwm](https://github.com/vukani-dev/dwm)
- st configuration based on [vukani-dev/st](https://github.com/vukani-dev/st)
- vim configuration based on [vukani-dev/nixvim](https://github.com/vukani-dev/nixvim)
