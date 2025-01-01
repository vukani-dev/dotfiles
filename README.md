# NixOS Configuration

A NixOS configuration for managing multiple machines

## Overview

This configuration manages multiple NixOS machines with shared base configuration and machine-specific customizations. It uses a modular approach with the following key components:

- Window Manager: dwm (custom build)
- Terminal: st (custom build)
- Shell: zsh with starship prompt
- Editor: Neovim (with specialized configurations for different languages)
- File Manager: yazi
- Browser: Firefox

## Machines

- **Marga**: Dell Precision 5560 with NVIDIA graphics
- **Necessary**: Microsoft Surface Pro
- **Dala**: System76 Lemur 
- **Monk**: Lenovo ThinkPad X220

## Key Features

### System Configuration
- Flake-based configuration
- Home Manager integration
- Automated garbage collection
- Hardware-specific optimizations
- Syncthing file synchronization
- Mullvad VPN support

### Desktop Environment
- Custom dwm build with:
  - Gaps
  - Status bar
  - Alt-tab functionality
  - Scratchpad
- Custom st terminal build with:
  - Font ligatures
  - True color support
  - Emoji support

### Development Tools
- Multiple Neovim configurations for:
  - Rust
  - Python
  - Web Development
  - Infrastructure as Code
- Git integration
- Docker support

### Media and Gaming
- Steam
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

- `flake.nix`: Main entry point and system configuration
- `global-config.nix`: Shared configuration across all machines
- `machines/`: Machine-specific configurations
- `modules/`: Reusable configuration modules
- `modules/global-config.nix`: bucket of applications
- `home-manager/`: User environment configuration

## Customization

### Adding a New Machine

1. Create a new directory under `machines/`
2. Copy and modify the `hardware-configuration.nix` for your hardware
3. Create a `default.nix` importing necessary modules
4. Add the machine to `flake.nix`

### Adding New Modules

1. Create a new `.nix` file under `modules/`
2. Import it in the relevant machine configuration

## License

GNU General Public License v3.0

## Credits

- dwm configuration based on [vukani-dev/dwm](https://github.com/vukani-dev/dwm)
- st configuration based on [vukani-dev/st](https://github.com/vukani-dev/st)
- vim configuration based on [vukani-dev/nixvim](https://github.com/vukani-dev/nixvim)