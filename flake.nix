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
      url = "github:vukani-dev/nixvim?rev=ebe34c1f445cc49504be6fa6a99808613e0bb512";
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
