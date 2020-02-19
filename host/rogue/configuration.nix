{ config, pkgs, lib, options, ... }:

let

  secretDir = "/secret";

in

{

  # nixpkgs.config.allowBroken = true;

#### Importing host configuration

  imports = [

    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>

    ../all.nix

    # Include all derivations
    ./derivations.nix

    ./deduplication.nix

    # ${curHostDir}./rollback.nix

    ./cachix.nix

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


  fileSystems."/home/pyro/hosts/ubu/stor" = {
    device = "192.168.88.5:/mnt/stor";
    fsType = "nfs";
    # Do not mount automatically, allow mount by local user, does not fail if not mounted
    options = [ "noauto" "user" "nolock" "async" "noacl" "nocto" "noatime" "nodiratime" "nofail"];
  };

  swapDevices = [ ];

  hardware.opengl.driSupport32Bit = true; # Enable 32bit acceleration

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

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.grub.extraPrepareConfig = "GRUB_CMDLINE_LINUX_DEFAULT='acpi_osi='";    # Be silent in responce to BIOS on request what OS is running (often BIOS disables functionality if it detects Linux)
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [
    "pti=off" "spectre_v2=off" "l1tf=off" "nospec_store_bypass_disable" "no_stf_barrier"
  ];

  nix.maxJobs = lib.mkDefault 8;
  nix.nixPath =
    options.nix.nixPath.default ++
    [ "nixpkgs-overlays=/etc/nixos/host/rogue /overlays/" ];
  # nix.buildCores = 1;    # Multithreading

  security.rngd.enable = true;
  # NOTE: 2019-03-11: Somehow does not parse sudoers file
  # security.sudo.extraRules = [
  #   {
  #     users = [ "pyro" ];
  #     commands = [
  #       {
  #         command = "mount.nfs 192.168.88.50:/mnt/stor /home/pyro/hosts/ubu/stor -o nolock,async,noacl,nocto,noatime,nodiratime";
  #         options = [ "SETENV" "NOPASSWD" ];
  #       }
  #     ];
  #   }
  # ];
  # security.sudo.extraConfig = "pyro ALL=(ALL:ALL) SETENV: ALL NOPASSWD: /run/current-system/sw/bin/mount.nfs 192.168.88.50:/mnt/stor";
  # security.hideProcessInformation = true;
  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  time.timeZone = "Europe/Kiev";

  programs.bash.enableCompletion = true;
  programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.java.enable = true;
  programs.kbdlight.enable = true;
  programs.light.enable = true;
  programs.wavemon.enable = true;
  programs.mosh.enable = true;

  services.emacs.defaultEditor = true;
  services.emacs.enable = true;
  services.emacs.install = true;
  services.haveged.enable = true;
  services.openssh.allowSFTP = false;
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
  # services.openssh.hostKeys = [
  #   {
  #     path = "/home/pyro/.ssh/id_rsa";
  #     type = "rsa";
  #     bits = 4096;
  #   }
  #   {
  #     path = "/home/pyro/.ssh/id_ed25519";
  #     type = "ed25519";
  #   }
  # ];
  # services.netdata.enable = true;
  # services.ipfs.autoMount = true;
  # services.ipfs.enable = true;
  # services.xserver.windowManager.xmonad.enable = true;
  # services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  services.avahi.enable = true; # For Pulseaudio networking
  services.fstrim.enable = true;             # Periodic trim of the filesystem with util-linux fstrim service
  services.printing.enable = true; # Enable CUPS to print documents.
  services.redshift.brightness.night = "1";
  services.redshift.enable = true;
  services.rpcbind.enable = true;
  services.teamviewer.enable = true;
  services.xserver.desktopManager.plasma5.enable = true; # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.libinput.enable = true;         # Enable touchpad support.
  services.xserver.videoDrivers = [ "nvidia" ];    # Proprietary nVidia driver

  services.hoogle.enable = true;
  services.hoogle.port = 8080;

  networking.firewall.enable = false;
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
    "192.168.122.195" = [ "srv" ];
    "192.168.122.251" = [ "clt" ];
  };
  #hardware.bumblebee = {
  #  enable = true;
  #  group = "video";
  #};

  virtualisation.docker.enable = true;
  virtualisation.docker.liveRestore = true;
  virtualisation.docker.extraOptions = "--experimental=true";
  virtualisation.docker.listenOptions = [ "/var/run/docker.sock" "0.0.0.0:2376" ];
  virtualisation.libvirtd.enable = true;

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.headless = false;

  services.kmscon.enable = true;
  services.urxvtd.package = true;

  fonts.enableDefaultFonts = true; # Enable a basic set of fonts providing several font styles and families and reasonable coverage of Unicode.
  fonts.enableFontDir = true; # Whether to create a directory with links to all fonts in /run/current-system/sw/share/X11-fonts
  fonts.enableGhostscriptFonts = true;
  fonts.fonts = with pkgs; [

    ## GUI Libraries: Fonts
    inconsolata-lgc	   # Fork of Inconsolata font, with proper support of Cyrillic and Greek
    liberation_ttf
    hack-font
    source-code-pro
    fira-code
    symbola    #	Basic Latin, Greek, Cyrillic and many Symbol blocks of Unicode
    dejavu_fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-extra
    unidings    #  Glyphs and Icons for blocks of The Unicode Standard


    ];
  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts.monospace = [ "Inconsolata LGC" "Iconsolata" ];

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
    "kvm"
    "ipfs"
    "cdrom"
  ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

  services.postgresql.enable = true;
  services.postgresql.package = pkgs.postgresql_10;
  services.postgresql.authentication = lib.mkForce ''
    # "local" is for Unix domain socket connections only
    local   all             all                                     trust
    local   all             all                                     md5
    # IPv4 local connections:
    host    all             all             127.0.0.1/32            trust
    # IPv6 local connections:
    host    all             all             ::1/128                 trust
    # Allow replication connections from localhost, by a user with the
    # replication privilege.
    local   replication     all                                     trust
    host    replication     all             127.0.0.1/32            trust
    host    replication     all             ::1/128                 trust
  '';

  services.nextcloud.enable = true;
  services.nextcloud.hostName = "testing";
  services.nextcloud.config.adminuser = "Anton-Latukha";
  services.nextcloud.config.adminpassFile = "${secretDir}/nextcloud-admin.pass";
  services.nextcloud.nginx.enable = true;
  services.nextcloud.home = "/var/www/nextcloud";
  services.nextcloud.autoUpdateApps.enable = true;
  services.nextcloud.config.dbtype = "pgsql";
  services.nextcloud.config.dbname = "nextcloud";
  services.nextcloud.config.dbhost = "localhost";
  services.nextcloud.config.dbport = 5432;
  services.nextcloud.config.dbuser = "nextcloud";
  services.nextcloud.config.dbpassFile = "${secretDir}/nextcloud-db.pass";
  services.nextcloud.config.dbtableprefix = "oc_";
  services.nextcloud.caching.apcu = true;
  services.nextcloud.caching.redis = true;
  services.nextcloud.config.extraTrustedDomains = [
    "*.*.*.*"
  ];
  # services.nextcloud.home = "/btrfs/midimportant/nextcloud";
  # services.nextcloud.config.overwriteProtocol = "https";
  # services.nextcloud.https = true;

  security.pam.services.pyro.enableKwallet = true;

  programs.tmux.keyMode = "vi";

  # services.ihaskell.enable = true;    # NOTE: 2019-09-21: Was broken due deps not ported to latest GHC
  services.jupyter.enable = true;
  services.jupyter.port = 8880;
  services.jupyter.group = "pyro";
  services.jupyter.notebookDir = "~/src/notebooks/";
  services.jupyter.user = "pyro";
  services.jupyter.password = "'sha1:02ea7ec9a0f5:6ac01fe3450b0de07726f336efbb4ec094a75314'";

  environment.sessionVariables = {
    SSH_AUTH_SOCK = "\"$XDG_RUNTIME_DIR\"/keepass-ssh-agent.socket";
  };
  # programs.ssh.startAgent = true; # FIXME: This does not binds to cutom user available socket

  services.btrfs.autoScrub.enable = true;    # Check data against metagate. BTRFS devs recommend 1m period, which is default period in NixOS.

  programs.cdemu.enable = true;
  programs.cdemu.group = "cdrom";
  programs.cdemu.gui = true;

}
