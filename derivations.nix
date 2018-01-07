{ config, pkgs, ... }:

let
  unstable = import <unstable> {};
in {
  environment.systemPackages = with pkgs; [
    #linuxPackages_4_14.kernel
   	#linuxPackages_4_4.nvidiabl
    #linuxPackages.acpi_call
    firmwareLinuxNonfree

    acpitool
    # Nix
    ktorrent
    dmidecode
    nix-repl
    nix-prefetch-git
    nixops
    stack2nix
    gparted

    # Libraries
    hunspell
    hunspellDicts.en-us
    mythes
	  aspell
    aspellDicts.en
    aspellDicts.ru
    aspellDicts.uk

    mesa
    #xorg.xf86videointel
    libdvdcss
    geoclue2
    ntfs3g
    zlib
	  glibc
    glibcLocales

    # Fonts
    hack-font
    source-code-pro

    # Console
    emacs
    nfs-utils
    git
    git-crypt
    #fwupd
    fish
    zsh
    dash
    mosh
    sshfs
    strace
    memtest86plus
    haveged
    os-prober
    rng_tools
    pciutils
    tmux
    file
    unoconv
    direnv      # For Fish: `echo 'eval (direnv hook fish)' >> /home/pyro/.config/fish/conf.d/direnv.fish`
    whois
    bind        # For `dig`
    ldns        # For DNS `drill` tool
    gnumake     # Make
    eject       # Utils-Linux, like for continious trim
    lshw
    ffmpeg

    youtube-dl
    python3
    ## Haskell
    ghc
    cabal-install
    cabal2nix
    unstable.stack
    hlint
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

    ### ALE
    rocksdb
    haskellPackages.universum
    haskellPackages.serokell-util
    # haskellPackages.cryptonite_0_24
    haskellPackages.statistics

    ## Configuration management
    ansible
    terraform

    ## Virtualization
    docker
    docker_compose
    qemu
    libvirt

    ## Programming
    shellcheck

    ## Deps
    networkmanager

    # GUI
    keepass
    wine
    tilix
    catfish
    redshift
    gsmartcontrol
    sqlitebrowser
    ## libreoffice
    libreoffice-fresh
    gnome3.cheese
    gnome3.dconf
    wireshark

    ## Virtualization
    virtualbox
    virtmanager

    ## Cloud
    awscli
    google-cloud-sdk

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

    ## Books
    calibre
    kdeApplications.okular

    ## Internet
    firefox
    chromium
    qbittorrent
    tor-browser-bundle-bin

    ### Messengers
    slack
    #    skype
    tdesktop
    pidgin
    franz
    #viber

    ## Remote
    x2goclient
    remmina

    ## Multimedia
    smplayer
    deadbeef
    spotify
    avidemux
    audaciousQt5
    kodi
    mkvtoolnix
    ffmpegthumbs
    mpv
    tvheadend
    #kodiPlugins.pvr-hts
	  #kodiPlugins.pvr-hdhomerun
    vlc
    mediainfo-gui
    handbrake

    ## Images
    inkscape
    gimp
    gnome3.eog

    ## Deps
    gnome3.adwaita-icon-theme

    # Unstable packages
    unstable.fwupd
    unstable.jdupes
    unstable.winusb

    # Custom local packages

    ## Serokell YT time track tool
    #yt-utilities.yt-utilities

    ## Games
    wesnoth
    hedgewars
    # freeciv
    freeciv_gtk
    # dwarf-fortress-packages.dwarf-fortress-unfuck
    # dwarf-fortress-packages.phoebus-theme
    dwarf-fortress-packages.dfhack
    dwarf-fortress-packages.dwarf-therapist
    dwarf-fortress
    xonotic
    freeorion
    # quake3game
    # nethack
  ];
}

