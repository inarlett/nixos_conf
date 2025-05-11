{
  config,
  dpi,
  inputs,
  hyprland-plugins,
  lib,
  pkgs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  # The home.packages option allows you to install Nix packages into your
  # environment.
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
      "org/gnome/desktop/sound" = {
        event-sounds = false;
      };
    };
  };

  gtk = {
    enable = true;
    font = {
      name = "Iosevka";
      # size = 10;
    };
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  home = {
    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };
    homeDirectory = "/home/inf";
    #packages = with pkgs.python312Packages; [
    #  compiledb
    #];
    packages =
      with pkgs;
      [
        # # Adds the 'hello' command to your environment. It prints a friendly
        # # "Hello, world!" when run.
        # pkgs.hello
        # # It is sometimes useful to fine-tune packages, for example, by applying
        # # overrides. You can do that directly here, just don't forget the
        # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
        # # fonts?
        # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

        # # You can also create simple shell scripts directly inside your
        # # configuration. For example, this adds a command 'my-hello' to your
        # # environment:
        # (pkgs.writeShellScriptBin "my-hello" ''
        #   echo "Hello, ${config.home.username}!"
        # '')

        # archivebox # insecure

        # dmd
        # glib
        # google-cloud-sdk
        # gping
        # haskellPackages.ghcup
        # kdePackages.okular
        # libsForQt5.full
        # llvmPackages.libcxx
        # llvmPackages.libcxxClang
        # mariadb
        # openai-whisper-cpp
        # rust-analyzer
        # rustdesk-flutter
        # rustlings
        # tdlib
        # volume
        # xautolock
        # yq
        #davinci-resolve-studio
        #nur.repos.lschuermann.vivado-2022_2
        #redshift
        #tor-browser
        #wolfram-engine
        #zed-editor
        agda
        aichat
        aider-chat
        alacritty
        anki-bin
        anydesk
        ardour
        (aspellWithDicts (
          dicts: with dicts; [
            en
            en-computers
            en-science
          ]
        ))
        audacity
        autotiling
        bear
        betterlockscreen
        bleachbit
        blender-hip
        blueman
        cabal-install
        cachix
        ccache
        clang
        clang-tools
        clash-verge-rev
        clinfo
        cling
        clipmenu
        clojure
        clojure-lsp
        cloudflare-warp
        cmake
        code-cursor
        conda
        #coreboot-toolchain.riscv
        coursier
        dbeaver-bin
        dconf
        deno
        dirstalk
        discord
        docker-compose
        dotnet-sdk
        dunst
        element-web
        espeak
        evcxr
        evtest
        feishu
        ffmpeg-full
        filezilla
        firejail
        flameshot
        fluent-reader
        fontforge
        freecad-wayland
        gammastep
        gh
        ghc
        ghidra
        ghostscript
        gimp
        git-lfs
        glew
        glfw
        go-musicfox
        goldendict-ng
        google-chrome
        gopls
        gparted
        gperf
        gradle
        graphviz
        gsl
        gtest
        gtkwave
        guile
        haskell-language-server
        hledger
        hledger-web
        hmcl
        home-manager
        html-tidy
        hugo
        imagemagick
        inkscape
        irssi
        jdt-language-server
        jetbrains.idea-community-bin
        jpm
        jq
        kdePackages.full
        krita
        lazydocker
        leiningen
        libllvm
        libnotify
        libreoffice-fresh
        libsForQt5.okular
        libsForQt5.kdeconnect-kde
        linux-wallpaperengine
        listen1
        lldb
        lsb-release
        maim
        mako
        maven
        mesa
        meson
        metals
        mill
        mindustry-wayland
        moonlight-qt
        motrix
        musescore
        nethack
        nil
        ninja
        nix-index
        nodePackages.gulp
        nodejs
        nyxt
        obs-studio
        obs-studio-plugins.obs-pipewire-audio-capture
        obs-studio-plugins.wlrobs
        #octave
        onboard
        onedrive
        openconnect
        openutau
        peazip
        pipx
        plantuml
        pnpm
        podman
        polybar
        pwvucontrol
        python3
        qFlipper
        qq
        ra-multiplex
        racket
        rclone
        rm-improved
        rocmPackages.rocm-runtime
        rocmPackages.rocm-smi
        rsshub
        rsync
        ruff-lsp # python lsp
        rustup
        sbcl
        sbt
        scala
        scilab-bin
        scrcpy
        screenkey
        scrot
        shotcut
        showmethekey
        siji
        slurp
        snapper
        solaar
        speedtest-cli
        spotify
        styluslabs-write
        tailscale
        tailwindcss
        telegram-desktop
        tesseract
        tigervnc
        tokei
        typst
        unifont
        unrar
        verilator
        vlc
        w3m
        warpd
        waydroid
        wayvnc
        wechat-uos
        wemeet
        wineWowPackages.full
        winetricks
        wl-clipboard
        wl-kbptr
        wofi
        wshowkeys
        xdg-ninja
        xmake
        xsettingsd
        xss-lock
        yosys
        zathura
        zeal
        zig
        zls
        zotero
      ]
      ++ (with pkgs.python312Packages; [
        compiledb
        manim
        pymupdf
      ])
      ++ (with pkgs.xfce; [ thunar ]);

    pointerCursor = {
      gtk.enable = true;
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      # size = 51;
      x11.enable = true;
    };
    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager. If you don't want to manage your shell
    # through Home Manager then you have to manually source 'hm-session-vars.sh'
    # located at either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/roam/etc/profile.d/hm-session-vars.sh
    #
    sessionVariables = {
      CM_HISTLENGTH = 31;
      TERMINAL = "kitty";
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = 1;
      #  CM_LAUNCHER = "rofi";
      #  NEMU_HOME = "/home/inf/repos/ics2024/nemu";
    };
    stateVersion = "25.05"; # Please read the comment before changing.
    username = "inf";
  };
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''

    '';
    plugins = [
      hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hy3
    ];
  };

  imports = [
    ../modules/user-home-common.nix
  ];

  programs = {
    aria2 = {
      enable = true;
    };
    bun = {
      enable = true;
    };
    emacs = {
      enable = true;
      package = pkgs.emacs-git;
      extraPackages = epkgs: [
        # pkgs.emacsPackages.jinx
        # pkgs.emacsPackages.rime
        # pkgs.librime
        # epkgs.tdlib
        epkgs.mu4e
        epkgs.pdf-tools
        epkgs.telega
        epkgs.vterm
        # epkgs.w3m
      ];
    };
    feh = {
      enable = true;
    };
    firefox = {
      enable = true;
    };
    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
    git = {
      enable = true;
      lfs.enable = true;
      userEmail = "insnath@outlook.com";
      userName = "inarlett";
    };
    go = {
      enable = true;
    };
    helix = {
      enable = true;
    };
    hyprlock = {
      enable = true;
    };
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    java = {
      package = pkgs.jdk8;
      enable = true;
    };
    kitty = {
      enable = true;
      settings = {
        enable_audio_bell = false;
      };
      # extraConfig = builtins.readFile ./kitty.conf;
    };
    mbsync = {
      enable = true;
    };
    mpv = {
      enable = true;
    };
    msmtp = {
      enable = true;
    };
    mu = {
      enable = true;
    };
    neovim = {
      enable = true;
    };
    #    obs-studio = {
    #      enable = true;
    #    };
    # opam = {
    #   enable = true;
    #   enableBashIntegration = true;
    #   enableZshIntegration = true;
    # };
    pandoc = {
      enable = true;
    };
    rofi = {
      cycle = true;
      enable = true;
      font = "Iosevka ${builtins.toString (builtins.floor (10 * dpi / 72))}";
      extraConfig = {
        modes = "drun";
        show-icons = true;
      };
      # theme = ./rofi.rasi;
    };
    texlive = {
      enable = true;
      extraPackages = tpkgs: {
        inherit (tpkgs)

          scheme-full
          xecjk
          ;
      };
    };
    tmux = {
      enable = true;
      extraConfig = "set -g mouse on\nset -g prefix M-x";
    };
    vscode = {
      enable = true;
    };
    yazi = {
      enable = true;
      #enableBashIntegration = true;
      enableZshIntegration = true;
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
    zathura = {
      enable = true;
    };
    zsh = {
      autosuggestion = {
        enable = true;
      };
      defaultKeymap = "emacs";
      enable = true;
      enableCompletion = true;
      initExtra = builtins.readFile ./zshrc;
      history = {
        size = 10000000;
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "fzf"
          "git"
          "man"
        ];
        # theme = "lambda";
      };
      syntaxHighlighting = {
        enable = true;
      };
    };
  };

  # qt = {
  #   enable = true;
  #   platformTheme = {
  #     name = "gnome";
  #   };
  #   style = {
  #     name = "adwaita-dark";
  #     package = pkgs.adwaita-qt;
  #   };
  # };
  xdg = {
    configFile = {
      "redshift/redshift.conf".source = ./redshift.conf;
      "hypr/hyprland.conf".source = ./hyprland.conf;
      "hypr/hyprlock.conf".source = ./hyprlock.conf;
      "sway/config".source = pkgs.lib.mkOverride 10 ./sway-config;
      "sway/binds.sway".source = ./binds.sway;
      "sway/modes.sway".source = ./modes.sway;
      "i3/config".source = ./i3-config;
      "polybar/config.ini".source = ./polybar-config.ini;
      "polybar/launch.sh" = {
        source = ./polybar-launch.sh;
        executable = true;
      };
      "yazi/yazi.toml".source = ./yazi.toml;
      "waybar/config".source = ./waybar-config;
      "waybar/style.css".source = ./style.css;
      #"zathura/zathurarc".source = ./zathurarc;
    };

    desktopEntries = {
      #   mupdf = {
      #     name = "Mupdf";
      #     genericName = "Web Browser";
      #     exec = "mupdf-x11 %f";
      #     terminal = false;
      #     categories = [
      #       "Application"
      #     ];
      #     mimeType = [
      #       "application/pdf"
      #     ];
      #   };

      VScode = {
        name = "VSCode";
        genericName = "Text Editor";
        exec = "code --ozone-platform=wayland";
        icon = "Vscode";
        categories = [
          "Application"
        ];
        mimeType = [
          "application/develop"
        ];
      };
      idea-community-bin = {
        name = "IDEA-CE";
        genericName = "Text Editor";
        exec = "idea-community -Dawt.toolkit.name=WLToolkit";
        categories = [
          "Application"
        ];
        mimeType = [
          "application/develop"
        ];
      };
      fluent-reader = {
        name = "fluent-reader";
        genericName = "reader";
        exec = "fluent-reader --proxy-server=socks5://127.0.0.1:7890";
        categories = [
          "Application"
        ];
      };
    };

  };

  xresources = {
    properties = {
      "Xft.antialias" = 1;
      "Xft.dpi" = 192;
      "Xft.hinting" = 1;
      "Xft.hintstyle" = "hintfull";
      "Xft.rgba" = "rgb";
    };
  };

  # xsession = {
  #   enable = true;
  #   windowManager = {
  #     xmonad = {
  #       enable = true;
  #       enableContribAndExtras = true;
  #     };
  #   };
  # };
}
