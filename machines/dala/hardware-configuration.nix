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

  boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "usb_storage" "sd_mod" "sdhci_pci"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.initrd.luks.devices."luks-3f78902d-f4f9-45d7-989d-00563ee931b9".device = "/dev/disk/by-uuid/3f78902d-f4f9-45d7-989d-00563ee931b9";
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/dc0949b5-8b55-49a1-ad4f-50053cf902d3";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-6597401d-f926-40a4-b922-b5877816a6e5".device = "/dev/disk/by-uuid/6597401d-f926-40a4-b922-b5877816a6e5";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/0891-FB8F";
    fsType = "vfat";
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
    {device = "/dev/disk/by-uuid/078a46a9-bfa8-4c11-8a1e-9bf6a9f66f68";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  networking.hostName = "dala";
}
