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

  boot = {

    #kernelPackages = pkgs.linuxPackages_4_15;
    loader.systemd-boot.enable = true;
    loader.grub.enable = true;
    loader.grub.version = 2;
    loader.grub.default = 2; # boot entry index in list
    loader.grub.extraPrepareConfig = "GRUB_CMDLINE_LINUX_DEFAULT='acpi_osi='";
    loader.grub.useOSProber = true;

    loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  };

  nix.autoOptimiseStore = true;    # Autodeduplicate files in store
  #nix.useSandbox = true;

  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Europe/Kiev";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs = {

    bash.enableCompletion = true;
    mtr.enable = true;
    fish.enable = true;

  };


  # List services that you want to enable:
  services = {

    haveged.enable = true;

    # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
      allowSFTP = false;
      passwordAuthentication = false;
      hostKeys = [
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

    };

    geoclue2.enable = true;
#    rpcbind.enable = true;    # NOTE: For NFS

    xserver = {                       # Enable the X11 windowing system.
      enable = true;
      layout = "us";
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true; # Enable the KDE Desktop Environment.
    };

    fstrim.enable = true;             # Periodic trim of the filesystem with util-linux fstrim service

    # Enable CUPS to print documents.
    # services.printing.enable = true;

    # Daemon must turn off after not needed
    fwupd.enable = true;
  };


  networking = {

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    firewall.enable = false;
    hostName = "homer"; # Define your hostname.
    networkmanager.enable = true;

  };

  hardware = {

    cpu.intel.updateMicrocode = true;
    enableAllFirmware = true;
    # Enable 32bit acceleration
    opengl.driSupport32Bit = true;
    pulseaudio.enable = true;

  };


  virtualisation = {

#    docker = {
#      enable = true;
#      liveRestore = true;
#      extraOptions = "--experimental=true";
#      listenOptions = [ "/var/run/docker.sock" "0.0.0.0:2376" ];
#    };

#    libvirtd = {
#      enable = true;
#    };

#    virtualbox.host = {
#      enable = true;
#      headless = false;
#    };

  };

  fonts = {
    enableDefaultFonts = true; # Enable a basic set of fonts providing several font styles and families and reasonable coverage of Unicode.
    enableFontDir = true; # Whether to create a directory with links to all fonts in /run/current-system/sw/share/X11-fonts
    enableGhostscriptFonts = true;
    fonts = with pkgs; [ hack-font source-code-pro liberation_ttf inconsolata-lgc ];
    fontconfig = {
      enable = true;
      ultimate = { # Formerly known as Infinality. Provides many font-specific rendering tweaks and customizable settings.
        enable = true;
        substitutions = "combi";
      };
      defaultFonts = {
        monospace = [ "Inconsolata LGC" "Iconsolata" ];
      };
    };
  };

  # HACK: (2017-12-29) Fixes systemd&kernel issue. Make log shut up about 'Specified group 'kvm' unknown'
  ## Check this after time. This shiuld be fixed in systemd.
  users.groups = { kvm = {}; };

  users.extraUsers.pyro = {

    isNormalUser = true;
    uid = 1000;
    home = "/home/pyro";
    description = "Anton Latukha";

    extraGroups = [
      "wheel"
      "networkmanager"
      "users"
      "audio"
      "docker"
      "video"
      "libvirtd"
      "vboxusers"
    ];


  };


  users.extraUsers.valera = {

    isNormalUser = true;
    uid = 1001;
    home = "/home/valera";
    description = "Valera Latukha";

    extraGroups = [
      "wheel"
      "networkmanager"
      "users"
      "audio"
      "video"
      "libvirtd"
      "vboxusers"
    ];


  };


  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
