{
  description = "Vukani's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-bleeding.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixvim-config = {
      url = "github:vukani-dev/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-bleeding,
    nixos-hardware,
    nixvim-config,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";

    bleedingEdgePackages = [
      "claude-code"
      "codex"
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
          nixos-hardware.nixosModules.dell-precision-5560
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
          nixos-hardware.nixosModules.microsoft-surface-pro-intel
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
          nixos-hardware.nixosModules.lenovo-thinkpad-x220
          nixvimModule
          {nixpkgs.overlays = overlays;}
        ];
      };
    };
  };
}
