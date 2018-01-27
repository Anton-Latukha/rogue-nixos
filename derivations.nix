{ config, pkgs, ... }:

let
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
    gnome3.adwaita-icon-theme    # Gnome icons

    ## GUI Libraries: Fonts
    hack-font
    source-code-pro


    # Console
    emacs
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

    ## Programming
    shellcheck

    ### C
	  glibc
    glibcLocales

    ### Haskell
    #leksah
    ghc
    cabal-install
    cabal2nix
    stack2nix
    hlint

    #### Haskell packages
    haskellPackages.apply-refact
    haskellPackages.stylish-haskell
    haskellPackages.hasktags
    haskellPackages.hoogle
    haskellPackages.ghc-mod
    haskellPackages.hindent
    haskellPackages.intero
    haskellPackages.hakyll    # Static webpage generator
    haskellPackages.aeson    # Required by hakyll&website
    haskellPackages.haddock
    haskellPackages.universum
    haskellPackages.serokell-util
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

    ## Office
    libreoffice-fresh
    #FIXME: calibre    # Python 2.7 odfpy does not building under NixOS
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
    kdeFrameworks.syntax-highlighting
    kwayland-integration
    filelight
    ark    p7zip    	unar
    kdeApplications.spectacle
    kdeApplications.kcalutils
    kdeFrameworks.kcmutils

    ## Internet
    firefox
    chromium
    qbittorrent
    tor-browser-bundle-bin

    ### Messengers
    pidgin

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
    # audaciousQt5

    ### Media Create
    avidemux
    mkvtoolnix
    mediainfo-gui
    handbrake

    ## Images
    gnome3.eog

    ### Images Create
    inkscape
    gimp


    # Unstable packages
    unstable.stack    # FIXME: Tune-out from unstable Haskell
    unstable.fwupd
    unstable.jdupes
    unstable.viber # FIXME: Can not instal from unstable, due to `nixpkgs.config.allowUnfree = true` not propagating to it
    unstable.teamviewer

    ## Games
    freeciv_gtk
    dwarf-fortress
    dwarf-fortress-packages.dwarf-therapist
    xonotic
    freeorion

    ### Games garage
    #hedgewars    # FIXME: It does not launch
    #dwarf-fortress-packages.dwarf-fortress-unfuck    # FIXME: Does not work. Investigate how to use.
    #dwarf-fortress-packages.phoebus-theme    # FIXME: Does not work. Investigate how to use.
    #dwarf-fortress-packages.dfhack    # FIXME: Does not work. Investigate how to use.
    #wesnoth    # Booring game
    #freeciv    # This packages provides terrible interface
    #quake3game
    #nethack

    # Custom local packages
  ];
}

