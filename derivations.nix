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
    # python36Packages.glances
    # python27Packages.virtual-display
    zsync
    # acoustidFingerprinter
    mc
    # telnet
    winusb
    # unetbootin
    ripgrep
    # sqlite
    # sqliteman
    cdrtools # Highly portable CD/DVD/BluRay command line recording software
    lzma
    tree

    ### Security
    # chkrootkit    # FIXME: On launch throws `chkrootkit: can't find 'strings'`, so reqires `binutils` on launch, but does not have that as a requirement in derivation.    # FIXME: Upstream: Also seems to have false-positives and problems
    # clamav    # FIXME: 2018-01-10: ERROR: Can't open/parse the config file /etc/clamav/freshclam.conf

    ### System Libraries

    # Nix
    nix-prefetch-git
    # nixops

    ## System Firmware
    firmwareLinuxNonfree

    ## System Drivers
    libGL # mesa
    libGLU # mesa tools
    xorg.xf86videointel
    xorg.xf86videoati

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
    #tetex    # FIXME: Org export to LaTeX -> PDF
    # texlive.combined.scheme-small    # FIXME: Trying troubleshoot Org -> LaTeX -> PDF
    pandoc
    zip    # Was requested for Org -> ODT
    unzip     # Was requested for Org -> ODT
    # neovim
    git
    # git-crypt    # store secrets inside
    sshfs
    # unoconv    # Convert between any document format supported by LibreOffice/OpenOffice
    direnv      # For Fish: `echo 'eval (direnv hook fish)' >> /home/pyro/.config/fish/conf.d/direnv.fish`
    whois
    # ldns        # For DNS `drill` tool
    # bind        # FIXME: For `dig`. Some day Drill going to be better.
    # gnumake
    # eject       # A set of system utilities for Linux, like for continious trim
    # lshw
    # python3
    # gtypist    # GNU typist
    # gitstats    # Generate Git statistics
    # cowsay
    alsaUtils

    # dos2unix    # Convert Windows special text symbols to Unix

    ## Configuration management
    # ansible
    # terraform-full
    # terraform-provider-libvirt    # -plugin-dir /run/current-system/bin/

    ## Virtualization
    # docker
    # docker_compose
    # qemu
    # libvirt
    # libguestfs    # Tools for accessing and modifying virtual machine disk images

    ### Cloud Virtualization
    # awscli
    # google-cloud-sdk

    ## Development Programming
    shellcheck
    # vscode
    meson
    # jq # A lightweight and flexible command-line JSON processor
    # bc # GNU software calculator
    ag    # New grep for code
    zeal    #	A simple offline API documentation browser

    ### C
	  glibc
    glibcLocales
	  gcc6   # Just for Factorio installer

    ### Java
    # openjdk10

    ### Haskell
    # leksah
    ghc
    # haskell.compiler.ghc802 # FIXME: 2018-04-24 `intero` and `ghc-mod` do not compile/support 8.2.2 still
    cabal-install
    cabal2nix
    # FIXME: 2018-06-22: Dows not compile in nixos-unstable:
    # [7 of 7] Compiling Stack2nix        ( src/Stack2nix.hs, dist/build/Stack2nix.o )
    # src/Stack2nix.hs:37:48: error:
    # Module ‘Nix.Parser’ does not export ‘parseNixString’
    #    |
    # 37 |                                                parseNixString)
    #    |                                                ^^^^^^^^^^^^^^
    # stack2nix

    hlint

    #### Haskell packages
    # haskellPackages.apply-refact
    haskellPackages.stylish-haskell
    haskellPackages.hlint
    # haskellPackages.hasktags # FIXME: 2018-06-22: Does not compile on nixos-unstable ### Failure in: 2:16.hs:0:these were not found tests/Test.hs:39 expected: ["t2","t3","t4","t5"] but got: []
    haskellPackages.hoogle
    # haskellPackages.ghc-mod # FIXME: 2017-04-24 Does not compile/support with GHC 8.2.2
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
    # yarn

    ## Deps
    networkmanager

    # GUI
    gparted
    # keepass
    wine
    tilix
    catfish
    redshift
    gsmartcontrol
    # sqlitebrowser # FIXME: 2018-06-23: Does not compile on nixos-unstable
    # gnome3.cheese
    gnome3.dconf
    wireshark
    stellarium
	  latte-dock
    digikam

    ## Office
    # libreoffice-fresh # FIXME: 2018-12-06: Does not compile on nixos-unstable
    calibre
    kdeApplications.okular

    ### Office libraries
    # hunspell # FIXME: 2018-12-06: Does not compile on nixos-unstable
    # hunspellDicts.en-us
    # mythes # FIXME: 2018-12-06: Does not compile on nixos-unstable
    aspell
    aspellDicts.en
    aspellDicts.ru
    aspellDicts.uk

    ## Virtualization
    # virtmanager


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
    k3b    # CD burner
    kmix    # 2019-06-21: NOTE: plasma audio applet does not treats xonar volume range right, only mutes.

    ## Internet
    firefox
    chromium
    qbittorrent # FIXME: 2018-06-23: Does not compile on nixos-unstable
    # tor-browser-bundle-bin

    ### Messengers
    # pidgin
    # skype

    ## Remote
    # x2goclient # FIXME: 2018-06-23: Does not compile on nixos-unstable
    # remmina

    ## Multimedia & Media
    ffmpeg-full
    pavucontrol
    pulseaudioFull
    # (mumble_git.override {
    #   pulseSupport = true;
    #   speechdSupport = true;
    #   })
    # mumble_overlay # FIXME: Normal Mumble hangs on start.
    # libopus
    opusTools
    opusfile
    flac

    ### Media Consume
    youtube-dl
    googleearth

    #### Video
    smplayer
    mpv
    kodi
    vlc

    #### Audio
    deadbeef
    spotify
    # picard
    # cmus    # CLI music player
    # audaciousQt5
    # clementine
    # gpodder

    ### Media Create
    # avidemux
    mkvtoolnix
    mediainfo-gui
    # unstable.handbrake
    # chromaprint    # For AcoustID fpcalc fingerprinting

    ## Images
    gnome3.eog

    ### Images Create
    inkscape
    gimp

    # Previously unstable packages
    #stack    # fuck stack
    fwupd    # FIXME: No fwupd.service
    jdupes
    # viber
    # teamviewer

    ## Games
    openmw
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
  ];
}

