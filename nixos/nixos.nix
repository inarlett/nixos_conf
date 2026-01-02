{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  rustdesk_tcp = lib.range 21115 21119;
  rustdesk_udp = [ 21116 ];
  steam_tcp = [
    27036
    27037
  ];
  steam_udp = [
    10400
    10401
    27031
    27036
  ]; # vr port and basic

in
{

  nixpkgs.config = {
    allowUnfree = true;
  };
  documentation = {
    dev = {
      enable = true;
    };
    enable = true;
    man = {
      generateCaches = false;
      man-db.enable = true;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    #    etc={
    #      "btrbk/btrbk.conf".text = ''
    #        timestamp_format long
    #        snapshot_preserve_min 2d
    #        snapshot_preserve 14d
    #
    #        volume /
    #          snapshot_dir snapshots
    #          target /backup/btrbk
    #          subvolume .
    #            snapshot_filter /etc/btrbk/exclude.filter
    #      '';
    #      "btrbk/exclude.filter".text=''
    #        - /nix/store/
    #        - /srv/
    #        - /var/lib/portables/
    #        - /var/lib/machines/
    #        - /tmp/
    #        - /var/tmp/
    #      '';
    #    };
    systemPackages =
      with pkgs;
      [
        #davinci-resolv
        btrbk
        ffmpeg_4
        gcc
        gtest
        #haskellPackages.ghcup
        icu
        jdk11
        jdk21
        jdk8
        kdePackages.qtmultimedia
        krb5.lib
        libcxx
        libGL
        libglvnd
        libsndfile
        libxcb
        libva-utils
        libdrm
        linuxHeaders
        linux-manual
        livecaptions
        lm_sensors
        man-pages
        man-pages-posix
        mesa
        mono
        ncurses
        nss
        ntfs3g
        polkit_gnome
        portaudio
        radeontop
        redsocks
        tldr
        touchegg
        util-linux.lib
        wayland-utils
        xdg-desktop-portal
        xdg-desktop-portal-wlr
        yubioath-flutter
      ]
      ++ (with pkgs.xorg; [
        libX11
        libXcursor
        libXrandr
        libXinerama
        libXcomposite
        libXdamage
        libXfixes
        libXrender
      ]);
    wordlist = {
      enable = true;
    };
    sessionVariables = {
      LD_LIBRARY_PATH = lib.makeLibraryPath (
        with pkgs;
        [
          ffmpeg_4
          alsa-lib
          pulseaudio
        ]
      );
      NIXOS_OZONE_WL = "1";
      WLR_RENDERER = "vulkan";
      AMD_VULKAN_ICD = "RADV";
    };
    variables = rec {
      VISUAL = "nvim";
      XCURSOR_SIZE = "64";
    };

  };
  i18n = {
    inputMethod = {
      fcitx5 = {
        waylandFrontend = true;
      };
      type = "fcitx5";
    };
  };

  imports = [
    ./modules/authenticator.nix
    ./modules/docker.nix
    ./modules/libvirt.nix
    ./modules/waydroid.nix
    ./modules/nixos-common.nix
    ./modules/record
    ./modules/zsh
    ./modules/gui
  ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs = {
    appimage = {
      enable = true;
      binfmt = true;
    };
    firejail = {
      enable = true;
    };
    gamemode = {
      enable = true;
      settings = {
        general = {
          renice = 10;
          ioprio = 0;
        };
        gpu = {
          apply_gpu_optimisations = "accept-responsibility";
          gpu_device = 1;
        };
      };
    };
    kdeconnect = {
      enable = true;
      package = pkgs.valent;
    };
    steam = {
      enable = true;
    };
    hyprland = {
      enable = true;
    };
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        readline
        xorg.libX11
        libx11
        libxcb
        krb5.lib
        #sta
        libgcc.lib
      ];
    };
    nh = {
      enable = true;
      flake = "/home/inf/.nixos"; # sets NH_OS_FLAKE variable for you
    };
    virt-manager = {
      enable = true;
    };
    ydotool = {
      group = "users";
      enable = true;
    };

  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
  services = {
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          energy_performance_preference = "power";
          governor = "powersave";
          turbo = "auto";
        };
        charger = {
          energy_performance_preference = "performance";
          governor = "performance";
          turbo = "auto";
        };
      };
    };
    acpid = {
      enable = true;
      logEvents = true;
    };
    apache-kafka = {
      enable = true;
      settings = {
        "log.dirs" = [ "/var/lib/apache-kafka" ];
        "zookeeper.connect" = "localhost:2181";
      };
    };
    cloudflare-warp = {
      enable = false;
    };
    cron = {
      enable = true;
      systemCronJobs = [
        "45 23 * * * inf notify-send '休息准备时间"
      ];
    };
    # aria2 = {
    #   enable = true;
    #   rpcSecretFile = /run/secrets/aria2-rpc-token.txt;
    # };

    #    daed = {
    #      enable = true;
    #      openFirewall = {
    #        enable = true;
    #        port = 12345;
    #      };
    #    };

    distccd = {
      enable = true;
    };
    fail2ban = {
      enable = true;
      jails = {

      };
    };
    fwupd = {
      enable = true;
    };
    geth = {
      logos = {
        enable = true;
      };
    };
    guix = {
      enable = true;
    };
    nginx = {
      enable = true;
    };
    mysql = {
      enable = true;
      package = pkgs.mariadb;
      settings = {
        client = {
          default-character-set = "utf8mb4";
        };
        mysqld = {
          character-set-server = "utf8mb4";
          collation-server = "utf8mb4_general_ci";
        };
      };
    };
    ollama = {
      enable = true;
      rocmOverrideGfx = "11.0.0";
      package = pkgs.ollama-rocm;
      acceleration = "rocm";
    };
    open-webui = {
      enable = true;
    };
    # Enable CUPS to print documents.
    printing = {
      enable = true;
    };
    rabbitmq = {
      enable = true;
    };
    #redsocks = {
    #  enable = true;
    #  redsocks = [
    #    {
    #      doNotRedirect = [
    #        "-d 1.2.0.0/16"
    #      ];
    #      port = 23456;
    #      proxy = "127.0.0.1:7890";
    #      redirectCondition = "--dport 80";
    #      type = "http-relay";
    #    }
    #  ];
    #};
    redis.servers = {
      logos = {
        enable = true;
      };
    };
    #        docs={
    #          SUBVOLUME = "/home/inf/Documents";
    #          ALLOW_USERS = [ "root" "inf" ]; # 允许哪些用户管理快照
    #          TIMELINE_CREATE = true;
    #          TIMELINE_CLEANUP = true;
    #        };
    #        roam={
    #          SUBVOLUME = "/home/inf/Roam";
    #          ALLOW_USERS = [ "root" "inf" ];
    #          TIMELINE_CREATE = true;
    #          TIMELINE_CLEANUP = true;
    #        };
    #        code={
    #          SUBVOLUME = "/home/inf/code";
    #          ALLOW_USERS = [ "root" "inf" ];
    #          TIMELINE_CREATE = true;
    #          TIMELINE_CLEANUP = true;
    #        };

    timesyncd = {
      enable = true;
      servers = [
        "ntp.aliyun.com"
      ];
    };
    tlp = {
      enable = true;
    };
    todesk = {
      enable = true;
    };
    touchegg = {
      enable = true;
    };
    # touchegg = {
    #   enable = false;
    # };
    # tts.servers = {
    #   logos = {
    #     enable = true;
    #   };
    # };
    xserver = {
      enable = true;
      windowManager = {
        i3 = {
          enable = true;
        };
      };
    };
    zookeeper = {
      enable = true;
    };
  };
  security.polkit = {
    enable = true;
  };
  systemd = {
    services = {
      apache-kafka.wantedBy = lib.mkForce [ ];
      distccd.wantedBy = lib.mkForce [ ];
      fwupd.wantedBy = lib.mkForce [ ];
      geth-logos.wantedBy = lib.mkForce [ ];
      guix-daemon.wantedBy = lib.mkForce [ ];
      mysql.wantedBy = lib.mkForce [ ];
      nginx.wantedBy = lib.mkForce [ ];
      ollama.wantedBy = lib.mkForce [ ];
      rabbitmq.wantedBy = lib.mkForce [ ];
      redis-logos.wantedBy = lib.mkForce [ ];
      zookeeper.wantedBy = lib.mkForce [ ];
    };
    tmpfiles.rules =
      let
        rocmEnv = pkgs.symlinkJoin {
          name = "rocm-combined";
          paths = with pkgs.rocmPackages; [
            rocblas
            hipblas
            clr
          ];
        };
      in
      [
        "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
      ];
  };

  system.stateVersion = "25.05"; # Did you read the comment?

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";
  virtualisation.spiceUSBRedirection.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
      };
    };
  };
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking = {
    firewall = {
      #switch to nftables
      checkReversePath = "loose";
      trustedInterfaces = [ "wlp2s0" ];
      #      extraInputRules = ''
      #        iifname "wlp2s0" tcp dport 22 accept
      #        iifname "lo" accept
      #      '';
      # ssh,vnc,livelinkface
      allowedTCPPorts = [
        22
        5900
        5901
        11111
        60752
      ]
      ++ rustdesk_tcp
      ++ steam_tcp;
      allowedUDPPorts = [
        22
        67
        53
        60752
      ]
      ++ rustdesk_udp
      ++ steam_udp;

    };

    #    networkmanager = {
    #      enable = true;
    #      dns ="none";
    #    };

    nameservers = [
      "127.0.0.1"
    ];
  };
  # Or disable the firewall altogether.

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
}
