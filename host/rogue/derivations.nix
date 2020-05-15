{ config, pkgs, ... }:

let
  # You need to update nondefault channel with: `nix-channel --update unstable`
  unstable = import <unstable> {

  # Pass the nixpkgs config to the unstable alias
  # to ensure `allowUnfree = true;` is propagated:
  config = config.nixpkgs.config;
};

  # pkgsf59d835e = import (pkgs.fetchFromGitHub {  # Holds working `emacsPackages.telega`
  #   owner = "NixOS";
  #   repo = "nixpkgs";
  #   rev = "f59d835e5bb412a55165f392eeb1ad236b6a09b6";
  #   sha256 = "12q3s12rzjdi1h215akd6fp15zwy056spx5mmipbmw9wd2ac4fcq";
  # }) {};

  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};  # Hasakell IDE Engine prebuild

  # Import overrrides:
  # pkgs = import <nixpkgs> { config = import ./config.nix; };

  keepass-with-plugins = pkgs.keepass.override {
      plugins = [
        pkgs.keepass-keeagent
        pkgs.keepass-keepassrpc
      ];
  };

in {
  environment.systemPackages = with pkgs; [

    # acpitool

    ### System CLIs
    fish
    zsh
    dash

    #### System CLIs additions

    mosh    # Remote delta shell
    tmux
    htop
    fzf
    bat
    prettyping
    bandwhich    # Display current network utilization by process, connection and remote IP/hostname
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
    python38Packages.pygments
    pythonPackages.youtube-dl    # For gPodder yt-dl extension.
    appimage-run
    acpid                       #  2020-03-19: NOTE: daemon for delivering ACPI events

    zsync
    acoustidFingerprinter
    mc
    telnet
    winusb
    unetbootin
    ripgrep
    ripgrep-all
    # sqlite
    # sqliteman
    cdrtools # Highly portable CD/DVD/BluRay command line recording software
    lzma
    tree
    testdisk
    asciinema
    wmctrl # interact with a EWMH/NetWM compatible X Window Manager.
    exiftool
    megatools

    ### Security
    chkrootkit    # FIXME: On launch throws `chkrootkit: can't find 'strings'`, so reqires `binutils` on launch, but does not have that as a requirement in derivation.    # FIXME: Upstream: Also seems to have false-positives and problems
    clamav    # FIXME: 2018-01-10: ERROR: Can't open/parse the config file /etc/clamav/freshclam.conf

    ### System Libraries

    # Nix
    nix-prefetch-git
    nixops    # FIXME: 2019-03-05: aiohttp-3.5.4 not supported for interpreter python2.7
    # cachix    # FIXME: 2019-01-02: Broken build

    ## System Firmware
    # firmwareLinuxNonfree

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


    # Console
    emacs
    emacsPackages.telega
    proselint    # Linter for prose (text)
    nodePackages.textlint
    nodePackages.textlint-plugin-latex
    nodePackages.textlint-rule-abbr-within-parentheses
    nodePackages.textlint-rule-alex
    nodePackages.textlint-rule-common-misspellings
    nodePackages.textlint-rule-diacritics
    nodePackages.textlint-rule-en-max-word-count
    nodePackages.textlint-rule-max-comma
    nodePackages.textlint-rule-no-start-duplicated-conjunction
    nodePackages.textlint-rule-period-in-list-item
    nodePackages.textlint-rule-stop-words
    nodePackages.textlint-rule-terminology
    nodePackages.textlint-rule-unexpanded-acronym
    nodePackages.textlint-rule-write-good

    gnuplot    # Org+GNU Plot
    drawio    # Free Software tool to drawing and exporting all kinds of diagrams
    texlive.combined.scheme-full    # FIXME: Trying troubleshoot Org -> LaTeX -> PDF
    libpgf
    pgf_graphics
    poppler_utils    # A PDF rendering utils & library. Has info util pdffonts
    pdf2svg    # For Emacs Luapdf2svg
    image_optim    # Utility is one CLI to all optimizers for diffrent formats
    diff-pdf     # Text and pixel-comparison of PDFs
    pgfplots
    pandoc
    librsvg    # Render SVG files using cairo (for Org export to PDF)
    wkhtmltopdf    # Render HTML into PDF using Qt WebKit rendering engine
    zip    # Was requested for Org -> ODT
    unzip     # Was requested for Org -> ODT
    fcrackzip    # Well, to sprinkle crack on it
    neovim
    git
    git-crypt    # store secrets inside
    gitstats
    haskellPackages.krank    # Tool lints comments in the code and tracks issue statuses
    mr    # Myrepos tool
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
    tdlib    # Official Telegram library Emacs Telega.el build upon
    gperf    # HACK: 2019-10-07: Seems like Emacs Telega requires it?
    cmake    # HACK: 2019-10-07: Seems like Emacs Telega requires it?
    gcc    # HACK: 2019-10-07: Seems like Emacs Telega requires it?
    libtgvoip    # For telega VoIP

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
    graphviz    # Also needed for Emacs PlantUML
    wakatime
    # mathematica needs downloaded mathematica
    patchelf

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
    cabal-install
    cabal2nix    # FIXME: 2019-09-28: Does not compile curently.
    # stack2nix    # 2019-06-21: FIXME: Does not compile.
    (all-hies.selection { selector = p: { inherit (p) ghc882 ghc865 ; }; }) #  2020-05-11: NOTE: ghc883 does not work cause of stack2nix is deprecated

    #### Haskell packages
    haskellPackages.ghcid    # Mini IDE for Haskell
    haskellPackages.hscolour
    haskellPackages.apply-refact
    #  2020-02-20: NOTE: Was marked as broken
    # haskellPackages.stylish-haskell    # Haskell code prettifier
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
    haskellPackages.statistics
    haskellPackages.structured-haskell-mode

    discord

    ## JS
    yarn

    ## CSS
    csslint

    ## Node
    nodejs

    ## Deps
    networkmanager

    # GUI
    anki
    gparted
    keepass-with-plugins
    wine    # FIXME: 2019-07-16: qt-base i632 does not compile https://github.com/NixOS/nixpkgs/issues/63829
    tilix
    catfish
    redshift
    gsmartcontrol
    sqlite
    sqlitebrowser
    gnome3.cheese
    gnome3.dconf
    wireshark
    stellarium
	  # latte-dock
    digikam
    # gitkraken
    bleachbit

    ## Office
    libreoffice-still
    calibre
    scribus
    djvu2pdf
    kdeApplications.okular
    bookworm
    gImageReader
    djvulibre
    gwenview

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
    redshift-plasma-applet # Add the plasma applet, use the service setting
    plasma-pa
    kdeApplications.dolphin-plugins
    kdeApplications.kdegraphics-thumbnailers
    kdeFrameworks.syntax-highlighting
    kwayland-integration
    filelight
    ark    p7zip
    ## unar ## TODO: compile problems
    kdeApplications.spectacle
    kdeApplications.kcalutils
    kdeFrameworks.kcmutils
    krename
    xfce.tumbler
    kdeFrameworks.kdesu
    akregator

    ## Internet
    firefox
    plasma-browser-integration
    xdg-desktop-portal    # Desktop integration portals for sandboxed apps (for Firefox use of Dolphin file picker)
    plasma5.xdg-desktop-portal-kde    # Desktop integration portals for sandboxed apps (for Firefox use of Dolphin file picker)
    chromium
    qbittorrent
    tor-browser-bundle-bin

    ### Messengers
    # pidgin
    skype
    teams    # Microsoft Teams
    tdesktop

    ## zoom-us # FIXME: 2019-08-02: Installation script tried to modify Qt settings, so had no permissions.

    ## Remote
    x2goclient
    remmina

    ## Integrations
    kdeconnect
    nextcloud-client

    ## Multimedia & Media
    ffmpeg-full
    pavucontrol
    pulseaudioFull
    # (mumble_git.override {
    #   pulseSupport = true;
    #   speechdSupport = true;
    #   })
    # mumble_overlay # FIXME: Normal Mumble hangs on start.
    pulseeffects                    #  Limiter, compressor, reverberation, equalizer and auto volume effects for Pulseaudio applications
    libopus
    opusTools
    opusfile
    fdk_aac
    flac
    audacity
    wavegain

    ### Media Consume
    youtube-dl

    #### Video
    smplayer
    mpv
    # kodi
    vlc
    syncplay

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
    handbrake
    chromaprint    # For AcoustID fpcalc fingerprinting

    ## Images
    # gnome3.eog
    # feh    # Image viewer configurable from CLI
    openjpeg    # Open-source JPEG 2000 codec
    # nomacs

    ### Images Create
    inkscape
    gimp
    imagemagickBig
    kcolorchooser

    # Previously unstable packages
    jdupes
    teamviewer

    ## Games
    dwarf-fortress-packages.dwarf-fortress-full
    # freeciv_gtk
    # dwarf-fortress
    # dwarf-fortress-packages.dwarf-fortress-unfuck
    # dwarf-fortress-packages.dwarf-therapist
    # dwarf-fortress-packages.phoebus-theme
    # dwarf-fortress-packages.dfhack
    # xonotic
    # freeorion # FIXME: 2018-06-22: nixos-unstable compile error
    # openxcom

    ### Games garage
    # hedgewars    # FIXME: It does not launch
    # dwarf-fortress-packages.dwarf-fortress-unfuck    # FIXME: Does not work. Investigate how to use.
    # dwarf-fortress-packages.phoebus-theme    # FIXME: Does not work. Investigate how to use.
    # dwarf-fortress-packages.dfhack    # FIXME: Does not work. Investigate how to use.
    # wesnoth    # Booring game
    # nethack

    # Custom local packages

    # Tiling life time
    xmonad-with-packages

    masterpdfeditor

    pinentry

    pinentry-emacs

    pinentry-qt

    lua53Packages.digestif  # Code analyzer for TeX.

    rubber

    tectonic

    libnotify

    libtool    # For compilation of Emacs vterm package

    jitsi    # For calls with Lesa

  ];
}

