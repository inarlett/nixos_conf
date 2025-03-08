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
  nixpkgs.config.allowUnfree = true;
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
      SDL2_mixer
      agda
      aichat
      aider-chat
      anki-bin
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
      blender
      blueman
      cabal-install
      cachix
      ccache
      clinfo
      clash-verge-rev
      clang
      clang-tools
      clipmenu
      clojure
      clojure-lsp
      cloudflare-warp
      cmake
      code-cursor
      conda
      coursier
      davinci-resolve-custom
      dbeaver-bin
      dconf
      deno
      discord
      # dmd
      dotnet-sdk
      dunst
      espeak
      evtest
      ffmpeg-full
      firejail
      fluent-reader
      fontforge
      freecad-wayland
      gh
      ghc
      ghostscript
      gimp
      glew
      glfw
      # glib
      goldendict-ng
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
      libreoffice-fresh
      linux-wallpaperengine
      # libsForQt5.full
      lldb
      # llvmPackages.libcxx
      # llvmPackages.libcxxClang
      # mariadb
      mesa
      maven
      meson
      metals
      mill
      mindustry-wayland
      moonlight-qt
      musescore
      nethack
      nil
      ninja
      nodejs
      nyxt
      onboard
      onedrive
      libsForQt5.okular
      # openai-whisper-cpp
      pipx
      plantuml
      pnpm
      podman
      python3
      qFlipper
      qq
      ra-multiplex
      racket
      rclone
      #redshift
      rocmPackages.rocm-smi
      rsshub
      rsync
      ruff-lsp # python lsp
      # rustlings
      rustdesk-flutter
      rustup
      sbt
      vlc
      # rust-analyzer
      sbcl
      scala
      scrcpy
      screenkey
      scrot
      SDL2
      shotcut
      showmethekey
      slurp
      snapper
      solaar
      speedtest-cli
      styluslabs-write
      tailscale
      tailwindcss
      # tdlib
      telegram-desktop
      tesseract
      tokei
      tor-browser
      translate-shell
      typescript
      typescript-language-server
      typst
      maim
      unrar
      # volume
      verilator
      w3m
      wechat-uos
      wineWowPackages.full
      winetricks
      wl-clipboard
      wofi
      wolfram-engine
      wshowkeys
      # xautolock
      xdg-ninja
      xmake
      xss-lock
      xsettingsd
      # yq
      zeal
      zig
      zls
      zotero
    ]++
    (with pkgs.python312Packages; [compiledb])
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
      package = pkgs.emacs30;
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
    obs-studio = {
      enable = true;
    };
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
          amsmath
          capt-of
          dvipng # for preview and export as html
          dvisvgm
          hyperref
          mylatexformat
          scheme-basic
          ulem
          wrapfig
          ;
      };
    };
    tmux = {
      enable = true;
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
      "yazi/yazi.toml".source=./yazi.toml;
      #"git/config".source = ./git-config;
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
      code = {
        name = "VSCode";
        genericName = "Text Editor";
        exec = "code --ozone-platform=wayland";
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
        genericName="Browser";
        exec = "google-chrome-stable --gtk-version=4";
        categories = [
          "Application"
        ];
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
