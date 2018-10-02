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

  # Use the systemd-boot EFI boot loader.
  boot = {

    #kernelPackages = pkgs.linuxPackages_4_15;
    loader.systemd-boot.enable = true;
    loader.grub.extraPrepareConfig = "GRUB_CMDLINE_LINUX_DEFAULT='acpi_osi='";
    loader.efi.canTouchEfiVariables = true;
    # extraModulePackages = with pkgs; [ linuxPackages_4_15.acpi_call ]; # Used to turn-off nvidia
    # kernelPackages = pkgs.linuxPackages_latest; nvidia requires 4.9

  };

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
    # gnupg.agent = { enable = true; enableSSHSupport = true; };

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

    netdata.enable = true;
    geoclue2.enable = true;
    rpcbind.enable = true;

    # HACK: dconf bug:
    # dbus.packages = with pkgs; [ gnome3.dconf ];

    avahi.enable = true; # For Pulseaudio networking

    xserver = {                       # Enable the X11 windowing system.
      enable = true;
      layout = "us";
      videoDrivers = [ "nvidia" ];    # Proprietary nVidia driver
      libinput.enable = true;         # Enable touchpad support.
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true; # Enable the KDE Desktop Environment.
      #windowManager.xmonad.enable = true;
      #windowManager.xmonad.enableContribAndExtras = true;
    };

    fstrim.enable = true;             # Periodic trim of the filesystem with util-linux fstrim service

    # Enable CUPS to print documents.
    # services.printing.enable = true;

    # Daemon must turn off after not needed
    fwupd.enable = true;
    # tvheadend.enable = true; # IPTV receiver backend
  };


  networking = {

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    firewall.enable = false;
    hostName = "rogue"; # Define your hostname.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;

  };

  hardware = {

    #bumblebee = {
    #  enable = true;
    #  group = "video";
    #};
    cpu.intel.updateMicrocode = true;
    enableAllFirmware = true;
    # Enable 32bit acceleration
    opengl.driSupport32Bit = true;
    pulseaudio.enable = true;

  };


  virtualisation = {

    docker = {
      enable = true;
      liveRestore = true;
      extraOptions = "--experimental=true";
      listenOptions = [ "/var/run/docker.sock" "0.0.0.0:2376" ];
    };

    libvirtd = {
      enable = true;
    };

    virtualbox.host = {
      enable = true;
      headless = false;
    };

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

  users.motd = ''
#!/bin/sh
 
upSeconds="$($(command -v) cut -d. -f1 /proc/uptime)"
secs=$((${upSeconds}%60))
mins=$((${upSeconds}/60%60))
hours=$((${upSeconds}/3600%24))
days=$((${upSeconds}/86400))
UPTIME=`printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs"`
 
# get the load averages
read one five fifteen rest < /proc/loadavg
 
echo "$(tput setaf 2)
   .~~.   .~~.    `date +"%A, %e %B %Y, %r"`
  '. \ ' ' / .'   `uname -srmo`$(tput setaf 1)
   .~ .~~~..~.
  : .~.'~'.~. :   Uptime.............: ${UPTIME}
 ~ (   ) (   ) ~  Memory.............: `cat /proc/meminfo | grep MemFree | awk {'print $2'}`kB (Free) / `cat /proc/meminfo | grep MemTotal | awk {'print $2'}`kB (Total)
( : '~'.~.'~' : ) Load Averages......: ${one}, ${five}, ${fifteen} (1, 5, 15 min)
 ~ .~ (   ) ~. ~  Running Processes..: `ps ax | wc -l | tr -d " "`
  (  : '~' :  )   IP Addresses.......: `ip a | grep glo | awk '{print $2}' | head -1 | cut -f1 -d/` and `wget -q -O - http://icanhazip.com/ | tail`
   '~ .~~~. ~'    Weather............: `curl -s "http://rss.accuweather.com/rss/liveweather_rss.asp?metric=1&locCode=EUR|UK|UK001|NAILSEA|" | sed -n '/Currently:/ s/.*: \(.*\): \([0-9]*\)\([CF]\).*/\2°\3, \1/p'`
       '~'
$(tput sgr0)"
echo '
 _____ ______                      
 \    \\     \                     
  \    \\     \                    
   \    \\     \ _____________     
    \    \\     \\            \    
     \    \\     \\____________\   
      \    \\     \ _____________  
      /    //      \\            \ 
     /    //        \\____________\
    /    //    /\    \             
   /    //    /  \    \            
  /    //    /    \    \           
 /____//____/      \____\          
    _    _           _        _ _   
   | |  | |         | |      | | |  
   | |__| | __ _ ___| | _____| | |  
   |  __  |/ _` / __| |/ / _ \ | |  
   | |  | | (_| \__ \   <  __/ | |  
   |_|  |_|\__,_|___/_|\_\___|_|_|
'
  '';

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
