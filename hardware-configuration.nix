# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
  boot.kernelModules = [ "kvm-intel" ];
  # boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/686fba70-397d-44b5-bc44-5cbfae938bab";
    fsType = "ext4";
    options = [ "noatime" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/162A-4BBC";
    fsType = "vfat";
    options = [ "noatime" ];
  };

  fileSystems."/win" = {
    device = "/dev/sda4";
    fsType = "ntfs";
    options = [ "noatime" "nofail" ];
  };

  fileSystems."/btrfs" = {
    device = "/dev/sda5";
    fsType = "btrfs";
    options = [ "noatime" "nofail" "compress=zstd"];
  };


  #  fileSystems."/stor" = {
  #    device = "ubu:/mnt/stor";
  #    fsType = "nfs";
  #    options = [ "nolock" "async" "noacl" "nocto" "noatime" "nodiratime" "nofail"];
  #  };

  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = "powersave";
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.systemWide = true;
  hardware.pulseaudio.tcp.enable = true;
  security.rtkit.enable = true;
  sound.enableOSSEmulation = true;
  hardware.pulseaudio.zeroconf.discovery.enable = true;
#  hardware.pulseaudio.extraConfig = ''
#    load-module module-null-sink sink_name=rtp
#    load-module module-rtp-send source=rtp.monitor
#    load-module module-rtp-recv
#  '';
}
