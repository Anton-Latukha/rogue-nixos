# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:{

  imports = [

    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Include all derivations
    ./derivations.nix

    # Deduplication
    ./deduplication.nix

    # Rollback
    # ./rollback.nix

  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.default = 0; # boot entry index in list
  boot.loader.grub.extraPrepareConfig = "GRUB_CMDLINE_LINUX_DEFAULT='acpi_osi='";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  nix.autoOptimiseStore = true;    # Autodeduplicate files in store

  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.allowBroken = true;

  # Set your time zone.
  time.timeZone = "Europe/Kiev";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.

  programs.bash.enableCompletion = true;
  programs.mtr.enable = true;
  programs.fish.enable = true;
  programs.java.enable = true;

  # List services that you want to enable:

  services.haveged.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.allowSFTP = false;
  services.openssh.passwordAuthentication = false;
  services.openssh.hostKeys = [
    {
      path = "/home/pyro/.ssh/id_rsa";
      type = "rsa";
      bits = 4096;
    }
    {
      path = "/home/pyro/.ssh/id_ed25519";
      type = "ed25519";
    }
  ];

  services.geoclue2.enable = true;
  # rpcbind.enable = true;    # NOTE: For NFS

  services.avahi.enable = true; # For Pulseaudio networking

  services.xserver = {                       # Enable the X11 windowing system.
    enable = true;
    layout = "us";
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true; # Enable the KDE Desktop Environment.
  };

  services.fstrim.enable = true;             # Periodic trim of the filesystem with util-linux fstrim service

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Daemon must turn off after not needed
  services.fwupd.enable = true;

  services.system-config-printer.enable = true;
  programs.system-config-printer.enable = true;
  services.printing.drivers = with pkgs; [ pkgs.canon-cups-ufr2 ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;
  networking.hostName = "homer"; # Define your hostname.
  networking.networkmanager.enable = true;

  hardware.cpu.intel.updateMicrocode = true;
  # hardware.enableAllFirmware = true;
  # Enable 32bit acceleration
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.enable = true;

  #  virtualisation.docker.enable = true;
  #  virtualisation.docker.liveRestore = true;
  #  virtualisation.docker.extraOptions = "--experimental=true";
  #  virtualisation.docker.listenOptions = [ "/var/run/docker.sock" "0.0.0.0:2376" ];

  #  virtualisation.libvirtd.enable = true;

  #  virtualisation.virtualbox.host.enable = true;
  #  virtualisation.virtualbox.host.headless = false;

  fonts.enableDefaultFonts = true; # Enable a basic set of fonts providing several font styles and families and reasonable coverage of Unicode.
  fonts.enableFontDir = true; # Whether to create a directory with links to all fonts in /run/current-system/sw/share/X11-fonts
  fonts.enableGhostscriptFonts = true;
  fonts.fonts = with pkgs; [ hack-font source-code-pro liberation_ttf inconsolata-lgc ];
  fonts.fontconfig.enable = true;
  fonts.fontconfig.ultimate = { # Formerly known as Infinality. Provides many font-specific rendering tweaks and customizable settings.
    enable = true;
    substitutions = "combi";
  };
  fonts.fontconfig.defaultFonts = {
    monospace = [ "Inconsolata LGC" "Iconsolata" ];
  };

  # HACK: (2017-12-29) Fixes systemd&kernel issue. Make log shut up about 'Specified group 'kvm' unknown'
  ## Check this after time. This shiuld be fixed in systemd.
  users.groups = { kvm = {}; };

  users.extraUsers.pyro.isNormalUser = true;
  users.extraUsers.pyro.uid = 1000;
  users.extraUsers.pyro.home = "/home/pyro";
  users.extraUsers.pyro.description = "Anton Latukha";

  users.extraUsers.pyro.extraGroups = [
    "wheel"
    "networkmanager"
    "users"
    "audio"
    "docker"
    "video"
    "libvirtd"
    "vboxusers"
    "pulse"
  ];

  users.extraUsers.valera.isNormalUser = true;
  users.extraUsers.valera.uid = 1001;
  users.extraUsers.valera.home = "/home/valera";
  users.extraUsers.valera.description = "Valera Latukha";

  users.extraUsers.valera.extraGroups = [
    "wheel"
    "networkmanager"
    "users"
    "audio"
    "video"
    "libvirtd"
    "vboxusers"
    "pulse"
  ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
