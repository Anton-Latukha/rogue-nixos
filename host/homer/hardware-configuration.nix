# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix> ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
  boot.kernelModules = [ "kvm-intel" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/d44c2571-b1c7-4c2c-ac76-d0a2d1b3ee37";
    fsType = "btrfs";
    options = [ "noatime" "nofail" "compress=zstd"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/cb24428c-792e-489a-9c54-a76dec889114";
    fsType = "ext4";
    options = [ "noatime" ];
  };

  # fileSystems."/win" = {
  #   device = "/dev/disk/by-uuid/01D443E2FABF7BF0";
  #   fsType = "ntfs";
  #   options = [ "noatime" "nofail" ];
  # };

  fileSystems."/ubu" = {
    device = "/dev/disk/by-uuid/cd57c403-5dc6-49b5-8a40-b04660d6021f";
    fsType = "btrfs";
    options = [ "noatime" "nofail" "compress=zstd" ];
  };

#  swapDevices = [ {
#    device = "/var/swapfile";
#    size = 4096;
#  } ];

  nix.maxJobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = "performance";

  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.systemWide = true;
  hardware.pulseaudio.tcp.enable = true;
  hardware.pulseaudio.tcp.anonymousClients.allowAll = true;
  security.rtkit.enable = true;
  sound.enableOSSEmulation = true;
  hardware.pulseaudio.zeroconf.discovery.enable = true;
#  hardware.pulseaudio.extraConfig = ''
#    load-module module-null-sink sink_name=rtp
#    load-module module-rtp-send source=rtp.monitor
#    load-module module-rtp-recv
#  '';

}
