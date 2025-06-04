{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ 
      (./. + "/nvidia.nix")
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
    initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-amd" "wl" ];
    extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/960a8de9-3167-487d-afd8-6351eb56ae7b";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/D84E-08CD";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/persistence" =
    { device = "/dev/disk/by-uuid/7ae086c3-ed05-43c9-a720-aa60d52cd0c5";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/bb736f13-4eb6-43ba-b546-eaca2adf5dc4"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp34s0.useDHCP = lib.mkDefault true;

  # disable the firewall
  networking.firewall.enable = false;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  system.stateVersion = "24.11";
}
