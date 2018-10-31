# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:{

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

  # Use the systemd-boot EFI boot loader.
  #boot.kernelPackages = pkgs.linuxPackages_4_15;
  boot.loader.systemd-boot.enable = true;
  boot.loader.grub.extraPrepareConfig = "GRUB_CMDLINE_LINUX_DEFAULT='acpi_osi='";
  boot.loader.efi.canTouchEfiVariables = true;
  #boot.extraModulePackages = with pkgs; [ linuxPackages_4_15.acpi_call ]; # Used to turn-off nvidia
  #boot.kernelPackages = pkgs.linuxPackages_latest; nvidia requires 4.9

  # nix.package = pkgs.nixStable2;    # Use unstable Nix version from NixOS repo
  nix.autoOptimiseStore = true;    # Autodeduplicate files in store
  nix.useSandbox = true;

  nixpkgs.config.allowUnfree = true;

  security.rngd.enable = true;
  #security.hideProcessInformation = true;

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  time.timeZone = "Europe/Kiev";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget

  programs.bash.enableCompletion = true;
  programs.mtr.enable = true;
  programs.fish.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  services.haveged.enable = true;
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
  services.netdata.enable = true;
  services.geoclue2.enable = true;
  services.redshift.enable = true;
  services.redshift.latitude = "50.4";
  services.redshift.longitude = "30.5";
  services.rpcbind.enable = true;
  services.avahi.enable = true; # For Pulseaudio networking
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.videoDrivers = [ "nvidia" ];    # Proprietary nVidia driver
  services.xserver.libinput.enable = true;         # Enable touchpad support.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true; # Enable the KDE Desktop Environment.
  #services.xserver.windowManager.xmonad.enable = true;
  #services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  services.fstrim.enable = true;             # Periodic trim of the filesystem with util-linux fstrim service
  #services.printing.enable = true; # Enable CUPS to print documents.
  services.fwupd.enable = true;

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    22
    ]
    ++ (lib.range 1714 1764) # KDE Connect
    ;
  networking.firewall.allowedUDPPorts = [
    22
    ]
    ++ (lib.range 1714 1764) # KDE Connect
    ;
  networking.hostName = "rogue"; # Define your hostname.
  networking.networkmanager.enable = true;

  networking.hosts = {
    "192.168.122.195" = [ srv ];
    "192.168.122.251" = [ clt ]
  }
  #hardware.bumblebee = {
  #  enable = true;
  #  group = "video";
  #};
  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableAllFirmware = true;
  hardware.opengl.driSupport32Bit = true; # Enable 32bit acceleration
  hardware.pulseaudio.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.liveRestore = true;
  virtualisation.docker.extraOptions = "--experimental=true";
  virtualisation.docker.listenOptions = [ "/var/run/docker.sock" "0.0.0.0:2376" ];
  virtualisation.libvirtd.enable = true;

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.headless = false;

  fonts.enableDefaultFonts = true; # Enable a basic set of fonts providing several font styles and families and reasonable coverage of Unicode.
  fonts.enableFontDir = true; # Whether to create a directory with links to all fonts in /run/current-system/sw/share/X11-fonts
  fonts.enableGhostscriptFonts = true;
  fonts.fonts = with pkgs; [ hack-font source-code-pro liberation_ttf inconsolata-lgc ];
  fonts.fontconfig.enable = true;
  fonts.fontconfig.ultimate.enable = true;
  fonts.fontconfig.ultimate.substitutions = "combi";
  fonts.fontconfig.defaultFonts.monospace = [ "Inconsolata LGC" "Iconsolata" ];

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
  ];

  users.motd = ''


                                                               ==    ##   ##    
  {}            {}        __                                    ===   ## ##     
 {}              {}       \ \ ___                            ========== ##   /  
 {}              {}        \ \\  \  _____         ->             ##      ## //  
 {}              {}         \ \\  \ \____\      ->->->         ##          //   
{}                {}        / //   \  ____     ->->->->   ######          //////
 {}              {}        / // /\  \ \____\    ->->->       ## \\       //     
 {}              {}       /_//_/  \__\            ->        ##  /\\ ########### 
 {}              {}                                            // \\    ##      
  {}            {}                                            //   \\    ##     


  '';

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
