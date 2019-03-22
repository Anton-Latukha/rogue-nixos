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
    # linuxPackages_4_14.kernel
   	# linuxPackages_4_4.nvidiabl
    # linuxPackages.acpi_call

    # acpitool

    ### System CLIs
    fish
    zsh
    dash

    #### System CLIs additions

    mosh    # remote delta shell
    tmux
    htop
    fzf
    bat
    prettyping
    gitAndTools.diff-so-fancy
    fd
    ncdu
    tldr
    noti

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
    # python36Packages.glances    # NOTE: 2018-12-31: Dep is broken
    # python27Packages.virtual-display    # FIXME: 2019-03-10: Fix build
    python27Packages.namebench

    zsync
    acoustidFingerprinter
    mc
    telnet
    winusb
    unetbootin
    ripgrep
    sqlite
    sqliteman
    cdrtools # Highly portable CD/DVD/BluRay command line recording software
    lzma
    tree
    testdisk-photorec
    # asciinema    # FIXME: 2019-03-21: error: aiohttp-3.5.4 not supported for interpreter python2.7

    ### Security
    chkrootkit    # FIXME: On launch throws `chkrootkit: can't find 'strings'`, so reqires `binutils` on launch, but does not have that as a requirement in derivation.    # FIXME: Upstream: Also seems to have false-positives and problems
    clamav    # FIXME: 2018-01-10: ERROR: Can't open/parse the config file /etc/clamav/freshclam.conf

    ### System Libraries

    # Nix
    nix-prefetch-git
    nixops
    # cachix    # FIXME: 2019-01-02: Broken build

    ## System Firmware
    firmwareLinuxNonfree

    ## System Drivers
    libGL # mesa
    libGLU # mesa tools
    xorg.xf86videointel
    # xorg.xf86videonouveau

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
    inconsolata-lgc	# Fork of Inconsolata font, with proper support of Cyrillic and Greek

    # Console
    emacs
    gnuplot    # Org+GNU Plot
    texlive.combined.scheme-full    # FIXME: Trying troubleshoot Org -> LaTeX -> PDF
    pandoc
    zip    # Was requested for Org -> ODT
    unzip     # Was requested for Org -> ODT
    fcrackzip    # Well, to sprinkle crack on it
    neovim
    git
    git-crypt    # store secrets inside
    sshfs
    # unoconv    # Convert between any document format supported by LibreOffice/OpenOffice
    direnv      # For Fish: `echo 'eval (direnv hook fish)' >> /home/pyro/.config/fish/conf.d/direnv.fish`
    whois
    ldns        # For DNS `drill` tool
    bind        # FIXME: For `dig`. Some day Drill going to be better.
    gnumake
    eject       # A set of system utilities for Linux, like for continious trim
    lshw
    python3
    gtypist    # GNU typist
    gitstats    # Generate Git statistics
    cowsay
    alsaUtils
    alsaTools    # Additional Tools to Utils
    psmisc    # A set of small useful utilities that use the proc filesystem (such as fuser, killall and pstree)
    gnupg

    dos2unix    # Convert Windows special text symbols to Unix

    ## Configuration management
    ansible
    terraform-full
    terraform-provider-libvirt    # -plugin-dir /run/current-system/bin/

    ## Virtualization
    docker
    docker_compose
    qemu
    libvirt
    #libguestfs    # Tools for accessing and modifying virtual machine disk images NOTE: Compiles every time

    ### Cloud Virtualization
    awscli
    google-cloud-sdk

    ## Development Programming
    shellcheck
    vscode
    meson
    jq # A lightweight and flexible command-line JSON processor
    bc # GNU software calculator
    ag    # New grep for code
    zeal    #	A simple offline API documentation browser
    plantuml

    ### Python
    # python36Packages.pylint    # FIXME: 2019-03-10: Not passing self-test
    python36Packages.flake8    # Syntax checking
    # jetbrains.pycharm-community

    ### C
	  glibc
    glibcLocales

    ### Java
    jdk11
    gradle

    ### Haskell
    ghc
    # haskell.compiler.ghc802 # FIXME: 2018-04-24 `intero` and `ghc-mod` do not compile/support 8.2.2 still
    cabal-install
    cabal2nix
    stack2nix

    hlint

    #### Haskell packages
    haskellPackages.apply-refact
    haskellPackages.stylish-haskell    # Haskell code prettifier     # FIXME: 2019-01-03: Build broken
    haskellPackages.hlint
    haskellPackages.hspec
    # haskellPackages.hasktags # FIXME: 2018-06-22: Does not compile on nixos-unstable ### Failure in: 2:16.hs:0:these were not found tests/Test.hs:39 expected: ["t2","t3","t4","t5"] but got: []
    haskellPackages.hoogle
    haskellPackages.hindent
    # haskellPackages.dante # FIXME: No Nix package
    # haskellPackages.intero # Intero is for Stack
    # haskellPackages.hakyll # Static webpage generator
    # haskellPackages.aeson # Required by hakyll&website
    # haskellPackages.haddock # FIXME: 2018-04-05 Doesn't compile
    # haskellPackages.universum
    # haskellPackages.serokell-util
    haskellPackages.statistics

    ## JS
    yarn

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
    # sqlitebrowser # FIXME: 2018-06-23: Does not compile on nixos-unstable
    gnome3.cheese
    gnome3.dconf
    wireshark
    stellarium
	  # latte-dock
    digikam
    #gitkraken

    ## Office
    libreoffice-still
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
    # redshift-plasma-applet # Use the service setting
    plasma-pa
    kdeApplications.dolphin-plugins
    kdeApplications.kdegraphics-thumbnailers
    kdeFrameworks.syntax-highlighting
    kwayland-integration
    filelight
    ark    p7zip    	# unar # does not compile ATM
    kdeApplications.spectacle
    kdeApplications.kcalutils
    kdeFrameworks.kcmutils
    krename
    xfce.tumbler
    kdeFrameworks.kdesu
    akregator

    ## Internet
    firefox
    chromium
    qbittorrent
    tor-browser-bundle-bin

    ### Messengers
    pidgin
    skype
    zoom-us

    ## Remote
    # x2goclient # FIXME: 2018-06-23: Does not compile on nixos-unstable
    remmina

    ## Multimedia & Media
    ffmpeg-full
    pavucontrol
    pulseaudioFull
    # (mumble_git.override {
    #   pulseSupport = true;
    #   speechdSupport = true;
    #   })
    # mumble_overlay # FIXME: Normal Mumble hangs on start.
    libopus
    opusTools
    opusfile
    flac
    audacity
    wavegain

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
    jdupes
    teamviewer

    ## Games
    # freeciv_gtk
    # dwarf-fortress
    # dwarf-fortress-packages.dwarf-fortress-unfuck
    # dwarf-fortress-packages.dwarf-therapist
    # dwarf-fortress-packages.phoebus-theme
    # dwarf-fortress-packages.dfhack
    # xonotic
    # freeorion # FIXME: 2018-06-22: nixos-unstable compile error

    ### Games garage
    # hedgewars    # FIXME: It does not launch
    # dwarf-fortress-packages.dwarf-fortress-unfuck    # FIXME: Does not work. Investigate how to use.
    # dwarf-fortress-packages.phoebus-theme    # FIXME: Does not work. Investigate how to use.
    # dwarf-fortress-packages.dfhack    # FIXME: Does not work. Investigate how to use.
    # wesnoth    # Booring game
    # nethack

    # Custom local packages

    # Tiling life time
    # xmonad-with-packages
  ];
}

