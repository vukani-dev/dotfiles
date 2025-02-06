# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/9e9cc9e1-c6d0-48e5-aa00-5077bf8de5e2";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/7AFA-721F";
    fsType = "vfat";
  };

  fileSystems."/mnt/jukwaa" = {
    device = "//10.0.0.4/jukwaa";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in ["${automount_opts},credentials=/etc/nixos/smb-service"];
  };

  fileSystems."/mnt/storage" = {
    device = "10.1.0.40:/mnt/storage";
    fsType = "nfs";
    options = [
      "noatime"
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
    ];
  };

  fileSystems."/mnt/vault" = {
    device = "10.1.0.40:/mnt/vault";
    fsType = "nfs";
    options = [
      "noatime"
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
    ];
  };
  swapDevices = [
    {device = "/dev/disk/by-uuid/7c80dad4-d10e-4a0c-9d74-569e1c743c1b";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  # surface configs
  # microsoft-surface.ipts.enable = true;
  # microsoft-surface.surface-control.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  networking.hostName = "necessary";
}
