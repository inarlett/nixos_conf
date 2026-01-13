{
  config,
  dpi,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  extra-libs-for-conda = with pkgs;[ libdrm ];
  conda-withrocm = pkgs.conda.override { extraPkgs = extra-libs-for-conda; };
  neovideWrapped = pkgs.writeShellScriptBin "neovide" ''
    #!${pkgs.bash}/bin/bash
    source /home/inf/Documents/scripts/env/api.sh
    exec ${pkgs.neovide}/bin/neovide "$@"
  '';
in
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
        event-sounds = true;
      };
    };
  };

  gtk = {
    enable = true;
    gtk2.extraConfig = ''
      gtk-application-prefer-dark-theme=1
      gtk-im-module="fcitx"
    '';
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-im-module = "fcitx";
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-im-module = "fcitx";
    };

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

      #      ".config/i3".source = config.lib.file.mkOutOfStoreSymlink i3_path;
      #      ".config/polybar".source = config.lib.file.mkOutOfStoreSymlink polybar_path;
    };
    homeDirectory = "/home/inf";
    packages =
      with pkgs;
      [
        #nur pkgs

        #regular
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
        bluetuith
        cabal-install
        cachix
        #calcurse
        ccache
        clang
        #clash-for-windows
        clang-tools
        clinfo
        cling
        clipmenu
        cloudflare-warp
        cmake
        code-cursor
        conda-withrocm
        #coreboot-toolchain.riscv
        coursier
        dbeaver-bin
        dconf
        deno
        dirstalk
        discord
        dotnet-sdk
        dunst
        element-web
        espeak
        evcxr
        evtest
        eww
        feishu
        ffmpeg-full
        filezilla
        firejail
        flameshot
        fluent-reader
        fontforge
        #freecad-wayland
        gammastep
        gh
        ghc
        ghidra
        ghostscript
        gimp
        git-lfs
        glew
        glfw
        #go-musicfox
        goldendict-ng
        google-chrome
        gopls
        gparted
        gperf
        gradle
        graphviz
        grim
        gsl
        gtest
        gtkwave
        guile
        haskell-language-server
        hledger
        hledger-web
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
        just
        krita
        leiningen
        libllvm
        libnotify
        libreoffice-fresh
        #linux-wallpaperengine
        listen1
        lldb
        lsb-release
        maim
        mako
        matlab
        maven
        meson
        metals
        moonlight-qt
        motrix
        musescore
        nautilus
        neovideWrapped
        neovim
        nethack
        nil
        ninja
        nix-index
        nix-ld
        nodePackages.gulp
        nodejs
        nyxt
        onboard
        onedrive
        openconnect
        openutau
        peazip
        pipx
        plantuml
        planify
        polkit-gnome-agent
        pnpm
        podman
        polybar
        pwvucontrol
        pyright
        python3
        qFlipper
        qq
        lesspipe
        lspmux
        racket
        #resholve #i prefer to run it(insecure) in shell env
        rclone
        ripgrep-all
        rm-improved
        rocmPackages.rocm-runtime
        rocmPackages.rocm-smi
        rsshub
        rsync
        rustdesk-flutter
#rust toolchain
        cargo
        rust-analyzer
        rustc
        sbcl
        sbt
        scala
        scrcpy
        screenkey
        scrot
        shotcut
        showmethekey
        siji
        slurp
        #snapper
        solaar
        speedtest-cli
        spotify
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
        #voice2sub
        w3m
        warpd
        waydroid
        wayvnc
        wechat
        wemeet
        wineWowPackages.full
        winetricks
        wl-kbptr
        wofi
        #wolfram-engine
        wpaperd
        wshowkeys
        xdg-ninja
        xsettingsd
        xss-lock
        yosys
        zathura
        zathuraPkgs.zathura_djvu
        zathuraPkgs.zathura_pdf_mupdf
        zig
        zls
        zotero
      ]
      ++ (with pkgs.python312Packages; [
        compiledb
        tkinter
        numpy
        jupyter
        ipykernel
        matplotlib
        scipy
      ]);

    pointerCursor = {
      gtk.enable = true;
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
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
      MOZ_ENABLE_WAYLAND = 1;

      #  CM_LAUNCHER = "rofi";
      #  NEMU_HOME = "/home/inf/repos/ics2024/nemu";
    };
    stateVersion = "25.05"; # Please read the comment before changing.
    username = "inf";
  };

  imports = [
    ../modules
    ../modules/user-home-common.nix
    ../modules/tools/nvim/lazy-path.nix
  ];

  programs = {
    aria2 = {
      enable = true;
    };
    bash = {
      enable = true;
      enableCompletion = true;
      historySize = 100000;
    };
    bun = {
      enable = true;
    };
    emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
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
    direnv = {
      enable = true;
      # enableBashIntegration =true;
      # enableFishIntegration = true;
      nix-direnv.enable = true;
      config = {
        hide_env_diff = true;
      };
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
    go = {
      enable = true;
    };
    helix = {
      enable = true;
    };
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    java = {
      package = pkgs.jdk17;
      enable = true;
    };
    kitty = {
      enable = true;
      settings = {
        enable_audio_bell = true;
      };
      extraConfig = builtins.readFile ./kitty.conf;
    };
    lazygit = {
      enable = true;
    };
    mbsync = {
      enable = true;
    };
    msmtp = {
      enable = true;
    };
    mu = {
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
    #    pandoc = {
    #      enable = true;
    #    };
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
      package = pkgs.vscode-fhs;
      enable = true;
    };
    yazi = {
      enable = true;
      enableBashIntegration = true;
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
      initContent = builtins.readFile ../modules/shell/zshrc;
      history = {
        size = 100000;
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
      #      "sway/config".source = pkgs.lib.mkOverride 10 ./sway-config;
      #      "sway/binds.sway".source = ./binds.sway;
      #      "sway/modes.sway".source = ./modes.sway;
      #      "zathura/zathurarc".source = ./zathurarc;
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
      anki = {
        name = "Anki";
        comment = "An intelligent spaced-repetition memory training program";
        genericName = "Flashcards";
        exec = "env QT_QUICK_BACKEND=software anki %f";
        icon = "anki";
        categories = [
          "Education"
          "Languages"
          "Qt"
        ];
        terminal = false;
        type = "Application";
        mimeType = [
          "application/x-apkg"
          "application/x-anki"
          "application/x-ankiaddon"
        ];
        settings = {
          X-GNOME-SingleWindow = "true";
          SingleMainWindow = "true";
          StartupWMClass = "anki";
        };
      };
      firefox = {
        name = "Firefox";
        genericName = "Web Browser";
        exec = "firefox";
        icon = "firefox";
        categories = [
          "Application"
          "Network"
          "WebBrowser"
        ];
        mimeType = [
          "text/html"
          "application/xhtml+xml"
          "application/xml"
          "application/rss+xml"
          "application/rdf+xml"
          "image/svg+xml"
          "x-scheme-handler/http"
          "x-scheme-handler/https"
          "x-scheme-handler/ftp"
          "x-scheme-handler/chrome"
          "x-scheme-handler/about"
          "x-scheme-handler/moz-icon"
        ];
        type = "Application";
      };
      QQ = {
        name = "QQ";
        exec = "steam-run qq %U";
        terminal = false;
        type = "Application";
        icon = "qq";
        settings = {
          StartupWMClass = "QQ";
        };
        categories = [ "Network" ];
        comment = "QQ";
      };
      VScode = {
        name = "VSCode";
        genericName = "Text Editor";
        exec = "env QT_SCALE_FACTOR= code";
        icon = "vscode";
        categories = [
          "Application"
        ];
        mimeType = [
          "application/develop"
        ];
      };
      yazi = {
        name = "Yazi";
        icon = "yazi";
        comment = "Blazing fast terminal file manager written in Rust, based on async I/O";
        terminal = false;
        exec = "kitty --class yazi-terminal y";
        type = "Application";
        mimeType = [ "inode/directory" ];
        categories = [
          "Utility"
          "Core"
          "System"
          "FileTools"
          "FileManager"
          "ConsoleOnly"
        ];
      };
      neovide = {
        name = "Neovide";
        genericName = "Neovim GUI";
        exec = "${neovideWrapped}/bin/neovide %F";
        type = "Application";
        icon = "${pkgs.neovide}/share/icons/hicolor/256x256/apps/neovide.png";
        terminal = false;
        comment = "No Nonsense Neovim Client in Rust";
        categories = [
          "Utility"
          "TextEditor"
        ];
        mimeType = [
          "text/english"
          "text/plain"
          "text/x-makefile"
          "text/x-c++hdr"
          "text/x-c++src"
          "text/x-chdr"
          "text/x-csrc"
          "text/x-java"
          "text/x-moc"
          "text/x-pascal"
          "text/x-tcl"
          "text/x-tex"
          "application/x-shellscript"
          "text/x-c"
          "text/x-c++"
        ];
      };
      nvim = {
        name = "Neovim";
        genericName = "Text Editor";
        exec = "kitty --class nvim-terminal nvim %f";
        terminal = false;
        type = "Application";
        icon = "nvim";
        categories = [
          "Utility"
          "TextEditor"
        ];
        startupNotify = false;
        mimeType = [
          "text/english"
          "text/plain"
          "text/x-makefile"
          "text/x-c++hdr"
          "text/x-c++src"
          "text/x-chdr"
          "text/x-csrc"
          "text/x-java"
          "text/x-moc"
          "text/x-pascal"
          "text/x-tcl"
          "text/x-tex"
          "application/x-shellscript"
          "text/x-c"
          "text/x-c++"
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
        exec = "fluent-reader";
        categories = [
          "Application"
        ];
      };
      zathura = {
        name = "Zathura";
        icon = "zathura";
        genericName = "reader";
        exec = "zathura %f";
        categories = [
          "Application"
        ];
      };
    };
    #    mimeApps = {
    #      enable = true;
    #      defaultApplications = {
    #        # 文本文件
    #        "text/plain" = [ "VSCode.desktop" ];
    #
    #        "image/png" = [ "firefox.desktop" ];
    #        "image/jpeg" = [ "firefox.desktop" ];
    #
    #        "video/mp4" = [ "vlc.desktop" ]; # VLC
    #        "video/x-matroska" = [ "vlc.desktop" ];
    #
    #        "application/pdf" = [ "zathura.desktop" ];
    #	"x-scheme-handler/http" = "firefox.desktop";
    #  	"x-scheme-handler/https" = "firefox.desktop";
    #      };
    #    };

  };

  xresources = {
    properties = {
      "Xft.antialias" = 1;
      "Xft.dpi" = 192;
      "Xft.hinting" = 1;
      "Xft.hintstyle" = "hintfull";
      "Xft.rgba" = "rgb";
      # "qt.scale.factor" = 2;
      # "qt.autoScreenScaleFactor" = 1;
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
