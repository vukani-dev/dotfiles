# NixOS Configuration

A NixOS configuration for managing multiple machines

## Overview

This configuration manages multiple NixOS machines with shared base configuration and machine-specific customizations. It uses a modular approach with the following key components:

- Window Manager: dwm (custom build)
- Terminal: st (custom build) / ghostty
- Shell: zsh with starship prompt
- Editor: Neovim (with specialized configurations for different languages)
- File Manager: yazi
- Browser: Librewolf

## Machines

- **Marga**: Dell Precision 5560 with NVIDIA graphics
- **Necessary**: Microsoft Surface Pro
- **Dala**: System76 Lemur
- **Monk**: Lenovo ThinkPad X220

## Hotkeys

### Window Management (Mod = Super)

| Keybind | Action |
|---------|--------|
| `Mod + h/j/k/l` | Focus window left/down/up/right |
| `Mod + Shift + h/j/k/l` | Move window left/down/up/right |
| `Mod + Ctrl + h/l` | Resize master area |
| `Mod + Return` | Zoom (swap with master) |
| `Mod + Shift + c` | Kill focused window |
| `Mod + Shift + q` | Quit dwm |
| `Mod + Space` | Toggle layout |
| `Mod + Shift + Space` | Toggle floating |
| `Mod + Shift + f` | Toggle fullscreen |
| `Mod + t` | Spiral/tiled layout |
| `Mod + f` | Floating layout |
| `Mod + m` | Monocle layout |
| `Mod + b` | Toggle bar |
| `Alt + Tab` | Alt-tab window switcher |
| `Mod + grave` | Toggle scratchpad terminal |

### Tags/Workspaces

| Keybind | Action |
|---------|--------|
| `Mod + 1-9` | Switch to tag 1-9 |
| `Mod + Shift + 1-9` | Move window to tag 1-9 |
| `Mod + Ctrl + 1-9` | Toggle tag view |
| `Mod + 0` | View all tags |
| `Mod + Shift + 0` | Tag window to all |
| `Mod + ,` | Focus previous monitor |
| `Mod + .` | Focus next monitor |
| `Mod + Shift + ,` | Move window to previous monitor |
| `Mod + Shift + .` | Move window to next monitor |

### Gaps

| Keybind | Action |
|---------|--------|
| `Mod + Mod4 + u` | Increase all gaps |
| `Mod + Mod4 + Shift + u` | Decrease all gaps |
| `Mod + Mod4 + 0` | Toggle gaps |
| `Mod + Mod4 + Shift + 0` | Reset gaps to default |

### Applications

| Keybind | Action |
|---------|--------|
| `Mod + Shift + Return` | Open terminal (ghostty) |
| `Mod + r` | Application launcher (rofi) |
| `Mod + w` | Browser (librewolf) |
| `Mod + d` | Discord |
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
| `Mod + Shift + s` | Screenshot |
| `Mod + Shift + b` | Bluetooth manager |
| `Mod + Shift + x` | Lock screen (slock) |

### Media Keys

| Keybind | Action |
|---------|--------|
| `XF86MonBrightnessUp` | Increase brightness 5% |
| `XF86MonBrightnessDown` | Decrease brightness 5% |
| `XF86AudioRaiseVolume` | Increase volume 5% |
| `XF86AudioLowerVolume` | Decrease volume 5% |
| `XF86AudioMute` | Toggle mute |

### Mouse

| Action | Result |
|--------|--------|
| `Mod + Left Click` | Move window |
| `Mod + Middle Click` | Toggle floating |
| `Mod + Right Click` | Resize window |
| `Mod + Shift + Left Click` | Drag resize master |

## Shell Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `rb` | `nh os switch ~/.dotfiles/` | Rebuild NixOS |
| `up` | `nh os switch ~/.dotfiles/ -u` | Update and rebuild |
| `bup` | `nix flake update nixpkgs-bleeding` | Update bleeding edge packages |
| `lg` | `lazygit` | Git TUI |
| `v` | `nvim .` | Open neovim in current dir |
| `ll` | `ls -l` | Long listing |
| `la` | `ls -a` | Show hidden files |

## Key Features

### System Configuration
- Flake-based configuration
- Home Manager integration
- Automated garbage collection (weekly, 14 day retention)
- Hardware-specific optimizations
- Syncthing file synchronization
- Mullvad VPN support
- Automatic display hotplug (autorandr)

### Desktop Environment
- Custom dwm build with:
  - Vanitygaps
  - Systray
  - Alt-tab functionality
  - Scratchpad
  - Status2d colored bar
  - Fibonacci/spiral layout
- Custom st terminal build with:
  - Font ligatures
  - True color support
  - Emoji support

### Performance
- zram swap compression
- earlyoom (prevents OOM freezes)
- fstrim for SSDs
- Gamemode for gaming
- NVIDIA power management for proper suspend/resume

### Development Tools
- Multiple Neovim configurations for:
  - Rust
  - Python
  - Web Development
  - Infrastructure as Code
- Git integration
- Docker support

### Media and Gaming
- Steam with gamemode
- MPV
- Jellyfin media player

## Installation

1. Clone this repository:

```bash
git clone https://github.com/vukani-dev/dotfiles ~/.dotfiles
```

2. Update the hostname in the appropriate machine configuration under `machines/`

3. Build and switch to the configuration:

```bash
nixos-rebuild switch --flake .#<hostname>
```

Replace `hostname` with your machine name (marga, necessary, dala, or monk)

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
│   ├── suckless/          # dwm & st configs
│   ├── displays/          # Per-machine display configs
│   ├── gaming.nix
│   ├── docker.nix
│   ├── syncthing.nix
│   └── ...
└── home-manager/          # User environment
    ├── home.nix
    ├── modules/           # User modules
    └── scripts/           # Shell scripts
```

## Customization

### Adding a New Machine

1. Create a new directory under `machines/`
2. Copy and modify the `hardware-configuration.nix` for your hardware
3. Create a `default.nix` importing necessary modules
4. Add a display config in `modules/displays/`
5. Add the machine to `flake.nix`

### Adding New Modules

1. Create a new `.nix` file under `modules/`
2. Import it in the relevant machine configuration

## License

GNU General Public License v3.0

## Credits

- dwm configuration based on [vukani-dev/dwm](https://github.com/vukani-dev/dwm)
- st configuration based on [vukani-dev/st](https://github.com/vukani-dev/st)
- vim configuration based on [vukani-dev/nixvim](https://github.com/vukani-dev/nixvim)
