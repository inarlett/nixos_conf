{
  lib,
  pkgs,
  ...
}:

{

  nixpkgs.config={
    allowUnfree = true;
    allowBroken = true;
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
    systemPackages = with pkgs; [
      #davinci-resolv
      gcc
      gtest
      #haskellPackages.ghcup
      icu
      jdk11
      jdk21
      jdk8
      libcxx
      libglvnd
      linuxHeaders
      linux-manual
      livecaptions
      lm_sensors
      man-pages
      man-pages-posix
      mesa
      ncurses
      nss
      ntfs3g
      polkit_gnome
      redsocks
      tldr
      util-linux.lib
      wayland-utils
      xdg-desktop-portal
      xdg-desktop-portal-wlr
    ];
    wordlist = {
      enable = true;
    };
    sessionVariables = {
      LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.util-linux.lib}/lib";
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
    ./modules/nixos-common.nix
    ./modules/zsh
  ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs = {
    appimage = {
      enable = true;
      binfmt = true;
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
      ];
    };
    virt-manager = {
      enable = true;
    };
    waybar = {
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
          energy_performance_preference = "balance_power";
          governor = "powersave";
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
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
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
      package = pkgs.ollama-rocm;
      acceleration = "rocm";
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
    snapper = {
      configs = {
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
      };
    };
    sunshine = {
      enable = true;
    };
    tlp = {
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
      polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };

      apache-kafka.wantedBy = lib.mkForce [ ];
      distccd.wantedBy = lib.mkForce [ ];
      docker.wantedBy = lib.mkForce [ ];
      waydroid-container.wantedBy = lib.mkForce [ ];
      fwupd.wantedBy = lib.mkForce [ ];
      geth-logos.wantedBy = lib.mkForce [ ];
      guix-daemon.wantedBy = lib.mkForce [ ];
      libvirtd.wantedBy = lib.mkForce [ ];
      libvirt-guests.wantedBy = lib.mkForce [ ];
      mysql.wantedBy = lib.mkForce [ ];
      nginx.wantedBy = lib.mkForce [ ];
      ollama.wantedBy = lib.mkForce [ ];
      rabbitmq.wantedBy = lib.mkForce [ ];
      redis-logos.wantedBy = lib.mkForce [ ];
      sunshine.wantedBy = lib.mkForce [ ];
      zookeeper.wantedBy = lib.mkForce [ ];
    };
  };

  system.stateVersion = "24.11"; # Did you read the comment?

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";
  virtualisation = {

    waydroid = {
      enable = true;
    };
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    libvirtd = {
      enable = true;
      qemu = {
        ovmf = {
          enable = true;
          packages = [
            (pkgs.OVMF.override {
              secureBoot = true;
              tpmSupport = true;
            }).fd
          ];
        };
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking = {
    firewall = {
      trustedInterfaces = [
        "docker0"
      ];
      interfaces.waydroid0 = {
        allowedUDPPorts = [
          67
          53
        ]; # 允许 DHCP 和 DNS
      };
      # ssh,vnc,livelinkface
      allowedTCPPorts = [
        22
        5900
        5901
        11111
      ];
      allowedUDPPorts = [
        67
        53
      ];
      extraCommands = ''
        iptables -A FORWARD -j ACCEPT
        ip6tables -A FORWARD -j ACCEPT
      '';
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
