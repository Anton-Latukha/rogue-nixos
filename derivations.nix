{ config, pkgs, ... }:

let
  # You need to update nondefault channel with: `nix-channel --update unstable`
  unstable = import <unstable> {
  # pass the nixpkgs config to the unstable alias
  # to ensure `allowUnfree = true;` is propagated:
  config = config.nixpkgs.config;
};
in {
  environment.systemPackages = with pkgs; [

    # System
    #linuxPackages_4_14.kernel
   	#linuxPackages_4_4.nvidiabl
    #linuxPackages.acpi_call

    # acpitool

    ### System CLIs
    fish
    zsh
    dash

    #### System CLIs additions

    mosh
    tmux
    htop

    ## System Tools
    dmidecode
    os-prober
    nfs-utils
    strace
    pciutils
    file
    binutils
    lsof
    btrfs-progs
    zstd
    python36Packages.glances
    python27Packages.virtual-display
    zsync
    acoustidFingerprinter
    mc
    telnet


    ### Security
    chkrootkit    # FIXME: On launch throws `chkrootkit: can't find 'strings'`, so reqires `binutils` on launch, but does not have that as a requirement in derivation.    # FIXME: Upstream: Also seems to have false-positives and problems
    clamav    # FIXME: 2018-01-10: ERROR: Can't open/parse the config file /etc/clamav/freshclam.conf

    ### System Libraries
    #rng_tools    # Requires hardware random number generators (TRNG)
    #haveged    # Gather entropy from sources. Not so effective.


    # Nix
    nix-repl
    nix-prefetch-git
    nixops

    ## System Firmware
    firmwareLinuxNonfree

    ## System Drivers
    mesa
    xorg.xf86videointel

    ## System Libraries
    libdvdcss
    geoclue2
    ntfs3g
    zlib

    # GUI Libraries
    ffmpegthumbs
    ffmpegthumbnailer # CLI application
    gnome3.adwaita-icon-theme    # Gnome icons

    ## GUI Libraries: Fonts
    liberation_ttf
    hack-font
    source-code-pro


    # Console
    emacs
    neovim
    git
    git-crypt
    sshfs
    unoconv    # Convert between any document format supported by LibreOffice/OpenOffice
    direnv      # For Fish: `echo 'eval (direnv hook fish)' >> /home/pyro/.config/fish/conf.d/direnv.fish`
    whois
    ldns        # For DNS `drill` tool
    bind        # FIXME: For `dig`. Some day Drill going to be better.
    gnumake
    eject       # A set of system utilities for Linux, like for continious trim
    lshw
    python3
    gtypist
    gitstats    # Generate Git statistics
    cowsay
    alsaUtils

    dos2unix    # Convert Windows special text symbols to Unix

    ## Configuration management
    ansible
    terraform

    ## Virtualization
    docker
    docker_compose
    qemu
    libvirt

    ### Cloud Virtualization
    awscli
    google-cloud-sdk

    ## Development Programming
    shellcheck
    vscode
    meson
    jq # A lightweight and flexible command-line JSON processor
    bc # GNU software calculator

    ### C
	  glibc
    glibcLocales

    ### Haskell
    #leksah
    ghc
    #haskell.compiler.ghc802 # FIXME: 2018-04-24 `intero` and `ghc-mod` do not compile/support 8.2.2 still
    cabal-install
    cabal2nix
    stack2nix
    hlint

    #### Haskell packages
    #haskellPackages.apply-refact
    haskellPackages.stylish-haskell
    haskellPackages.hlint
    haskellPackages.hasktags
    haskellPackages.hoogle
    #haskellPackages.ghc-mod # FIXME: 2014-04-24 Does not compile/support with GHC 8.2.2
    haskellPackages.hindent
    #haskellPackages.dante # FIXME: No Nix package
    #haskellPackages.intero # Intero is for Stack
    #haskellPackages.hakyll # Static webpage generator
    #haskellPackages.aeson # Required by hakyll&website
    #haskellPackages.haddock # FIXME: 2018-04-05 Doesn't compile
    #haskellPackages.universum
    #haskellPackages.serokell-util
    haskellPackages.statistics


    ## Deps
    networkmanager

    # GUI
    gparted
    keepass
    wine
    tilix
    catfish
    redshift
    gsmartcontrol
    sqlitebrowser
    gnome3.cheese
    gnome3.dconf
    wireshark
    stellarium
	  latte-dock
    digikam

    ## Office
    libreoffice-fresh
    calibre
    kdeApplications.okular

    ### Office libraries
    hunspell
    hunspellDicts.en-us
    mythes
    aspell
    aspellDicts.en
    aspellDicts.ru
    aspellDicts.uk

    ## Virtualization
    virtmanager


    ## KDE Plasma
    plasma-nm
    kate
    ksysguard
    kdeconnect
    redshift-plasma-applet
    plasma-pa
    kdeApplications.dolphin-plugins
    kdeApplications.kdegraphics-thumbnailers
    kdeFrameworks.syntax-highlighting
    kwayland-integration
    filelight
    ark    p7zip    	unar
    kdeApplications.spectacle
    kdeApplications.kcalutils
    kdeFrameworks.kcmutils
    krename
    xfce.tumbler

    ## Internet
    firefox
    chromium
    qbittorrent
    tor-browser-bundle-bin

    ### Messengers
    pidgin
    skype

    ## Remote
    x2goclient
    remmina

    ## Multimedia & Media
    ffmpeg

    ### Media Consume
    youtube-dl

    #### Video
    smplayer
    mpv
    kodi
    vlc

    #### Audio
    deadbeef
    spotify
    picard
    cmus    # CLI music player
    # audaciousQt5
    clementine
    gpodder

    ### Media Create
    avidemux
    mkvtoolnix
    mediainfo-gui
    unstable.handbrake
    chromaprint    # For AcoustID fpcalc fingerprinting

    ## Images
    gnome3.eog

    ### Images Create
    inkscape
    gimp


    # Previously unstable packages
    #stack    # fuck stack
    fwupd    # FIXME: No fwupd.service
    jdupes
    #viber
    teamviewer

    ## Games
    freeciv_gtk
    dwarf-fortress
    dwarf-fortress-packages.dwarf-fortress-unfuck
    dwarf-fortress-packages.dwarf-therapist
    dwarf-fortress-packages.phoebus-theme
    dwarf-fortress-packages.dfhack
    xonotic
    freeorion

    ### Games garage
    #hedgewars    # FIXME: It does not launch
    #dwarf-fortress-packages.dwarf-fortress-unfuck    # FIXME: Does not work. Investigate how to use.
    #dwarf-fortress-packages.phoebus-theme    # FIXME: Does not work. Investigate how to use.
    #dwarf-fortress-packages.dfhack    # FIXME: Does not work. Investigate how to use.
    #wesnoth    # Booring game
    #nethack

    # Custom local packages
  ];
}

