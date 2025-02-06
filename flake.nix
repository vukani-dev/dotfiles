{
  description = "Vukani's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-hardware = {
      url = "github:nixos/nixos-hardware";
      flake = false;
    };
    nixvim-config = {
      url = "github:vukani-dev/nixvim?rev=79331ee9646ef2016b7d1ff08c852d23ec17a48c";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
  };

  outputs = {
    nixpkgs,
    nix-hardware,
    nixvim-config,
    ghostty,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";

    nixvimModule = {pkgs, ...}: {
      environment.systemPackages = [
        nixvim-config.packages.${system}.default
        (pkgs.writeShellScriptBin "nvim-rust" ''
          ${nixvim-config.packages.${system}.rust}/bin/nvim "$@"
        '')
        (pkgs.writeShellScriptBin "nvim-python" ''
          ${nixvim-config.packages.${system}.python}/bin/nvim "$@"
        '')
        (pkgs.writeShellScriptBin "nvim-web" ''
          ${nixvim-config.packages.${system}.web}/bin/nvim "$@"
        '')
        (pkgs.writeShellScriptBin "nvim-iac" ''
          ${nixvim-config.packages.${system}.iac}/bin/nvim "$@"
        '')
      ];
    };
    ghosttyModule = {...}: {
      environment.systemPackages = [
        ghostty.packages.${system}.default
      ];
    };
  in {
    nixosConfigurations = {
      marga = lib.nixosSystem {
        specialArgs = {
          inherit inputs system;
        };
        modules = [
          ./machines/marga
          (nix-hardware + /dell/precision/5560)
          nixvimModule
          ghosttyModule
        ];
      };
      necessary = lib.nixosSystem {
        specialArgs = {
          inherit inputs system;
        };
        modules = [
          ./machines/necessary
          (nix-hardware + /microsoft/surface/surface-pro-intel)
          nixvimModule
        ];
      };
      dala = lib.nixosSystem {
        specialArgs = {
          inherit inputs system;
        };
        modules = [
          ./machines/dala
          nixvimModule
        ];
      };
      monk = lib.nixosSystem {
        specialArgs = {
          inherit inputs system;
        };
        modules = [
          ./machines/monk
          (nix-hardware + /lenovo/thinkpad/x220)
          nixvimModule
        ];
      };
    };
  };
}
