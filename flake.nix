{
  description = "Vukani's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-bleeding.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-hardware = {
      url = "github:nixos/nixos-hardware";
      flake = false;
    };
    nixvim-config = {
      url = "github:vukani-dev/nixvim?rev=87d482b752a1c2430e49604e01e8a0ef3aa1f9c0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-bleeding,
    nix-hardware,
    nixvim-config,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";

    bleedingEdgePackages = [
      "claude-code"
      "code-cursor-fhs"
    ];

    pkgs-bleeding = import nixpkgs-bleeding {
      inherit system;
      config.allowUnfree = true;
    };

    overlays = [
      (
        final: prev:
          lib.genAttrs bleedingEdgePackages (
            name:
              pkgs-bleeding.${name}
          )
      )
    ];

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
          {nixpkgs.overlays = overlays;}
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
          {nixpkgs.overlays = overlays;}
        ];
      };
      dala = lib.nixosSystem {
        specialArgs = {
          inherit inputs system;
        };
        modules = [
          ./machines/dala
          nixvimModule
          {nixpkgs.overlays = overlays;}
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
          {nixpkgs.overlays = overlays;}
        ];
      };
    };
  };
}
