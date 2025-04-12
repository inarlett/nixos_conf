{
  dpi,
}:
{
  config,
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
    packages = with pkgs; [
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
      agda
      aichat
      alacritty
      aider-chat
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
      bear
      go-musicfox
      betterlockscreen
      bleachbit
      blender-hip
      blueman
      cabal-install
      cachix
      ccache
      clinfo
      clang
      clang-tools
      clash-verge-rev
      clipmenu
      clojure
      clojure-lsp
      cloudflare-warp
      cmake
      code-cursor
      conan
      conda
      coursier
      #davinci-resolve-studio
      dbeaver-bin
      dconf
      deno
      discord
      # dmd
      dotnet-sdk
      dunst
      element-web
      espeak
      evtest
      ffmpeg-full
      filezilla
      firejail
      flameshot
      fluent-reader
      fontforge
      freecad-wayland
      git-lfs
      gh
      ghc
      ghidra
      ghostscript
      gimp
      glew
      glfw
      # glib
      goldendict-ng
      google-chrome
      
      # google-cloud-sdk
      gopls
      gparted
      gperf
      # gping
      gradle
      graphviz
      gsl
      gtest
      gtkwave
      guile
      # haskellPackages.ghcup
      haskell-language-server
      hledger
      hledger-web
      hmcl
      html-tidy
      hugo
      imagemagick
      inkscape
      jdt-language-server
      jetbrains.idea-community-bin
      jq
      kdePackages.full
      # kdePackages.okular
      krita
      leiningen
      libllvm
      libnotify
      libreoffice-fresh
      linux-wallpaperengine
      listen1
      # libsForQt5.full
      lldb
      # llvmPackages.libcxx
      # llvmPackages.libcxxClang
      # mariadb
      jpm
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
      nodejs
      nodePackages.gulp
      nyxt
      octave
      onboard
      onedrive
      openconnect
      libsForQt5.okular
      # openai-whisper-cpp
      obs-studio
      obs-studio-plugins.obs-pipewire-audio-capture
      obs-studio-plugins.wlrobs
      peazip
      pipx
      plantuml
      pnpm
      podman
      pwvucontrol
      python3
      qFlipper
      qq
      ra-multiplex
      racket
      rclone
      rm-improved
      #redshift
      rocmPackages.rocm-smi
      rsshub
      rsync
      ruff-lsp # python lsp
      # rustlings
      #rustdesk
      rustup
      sbt
      vlc
      # rust-analyzer
      sbcl
      scala
      scrcpy
      screenkey
      scrot
      shotcut
      showmethekey
      slurp
      snapper
      solaar
      speedtest-cli
      spotify
      styluslabs-write
      tailscale
      tailwindcss
      # tdlib
      telegram-desktop
      tesseract
      tigervnc
      tokei
      tor
      #tor-browser
      translate-shell
      typescript
      typescript-language-server
      typst
      maim
      unrar
      # volume
      #nur.repos.lschuermann.vivado-2022_2
      verilator
      wayvnc
      w3m
      wechat-uos
      wemeet
      windsurf
      wineWowPackages.full
      winetricks
      wl-clipboard
      wl-kbptr
      wofi
      wpsoffice
      #wolfram-engine
      wshowkeys
      # xautolock
      xdg-ninja
      xmake
      xss-lock
      xsettingsd
      # yq
      zeal
      #zed-editor
      zig
      zls
      zotero
    ]++
    (with pkgs.python312Packages; [
      compiledb
      manim
      pymupdf
    ])
    ++
    (with pkgs.xfce; [thunar]);

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
      CM_LAUNCHER = "rofi";
      TERMINAL = "kitty";
      MOZ_ENABLE_WAYLAND = 1;
      NEMU_HOME = "/home/inf/repos/ics2024/nemu";
    };
    stateVersion = "24.11"; # Please read the comment before changing.
    username = "inf";
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
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    java = {
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
          ;
      };
    };
    tmux = {
      enable = true;
      extraConfig="set -g mouse on\nset -g prefix M-x";
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
      "sway/config".source = pkgs.lib.mkOverride 10 ./sway-config;
      "sway/binds.sway".source = ./binds.sway;
      "sway/modes.sway".source = ./modes.sway;
      "i3/config".source = ./i3-config;
      "yazi/yazi.toml".source=./yazi.toml;
      "waybar/config".source=./waybar-config;
      "waybar/style.css".source=./style.css;
      
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
      idea-community-bin= {
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
        name="fluent-reader";
        genericName="reader";
        exec = "fluent-reader --proxy-server=socks5://127.0.0.1:7890";
        categories = [
          "Application"
        ];
      };
      Google-Chrome = {
        name="Google-Chrome";
        icon="google-chrome-stable";
        genericName="Browser";
        exec = "google-chrome-stable --gtk-version=4";
        categories = [
          "Application"
        ];
      };
      spotifree = {
        name="spotifree";
        icon = "spotify";
        genericName="Music Player";
        exec = "/home/inf/.shell/spotify-starter.sh";
        categories = [ "Audio" "Music" "Player" ];
      };
    };
    
  };

  xresources = {
    properties = {
      "Xft.antialias" = 1;
      "Xft.dpi" = dpi;
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
