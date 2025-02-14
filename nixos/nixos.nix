{
  lib,
  pkgs,
  ...
}:

{
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
      (let base = pkgs.appimageTools.defaultFhsEnvArgs; in
      pkgs.buildFHSUserEnv (base // {
      name = "fhs";
      targetPkgs = pkgs: 
        # pkgs.buildFHSUserEnv 只提供一个最小的 FHS 环境，缺少很多常用软件所必须的基础包
        # 所以直接使用它很可能会报错
        #
        # pkgs.appimageTools 提供了大多数程序常用的基础包，所以我们可以直接用它来补充
        (base.targetPkgs pkgs) ++ (with pkgs; [
          pkg-config
          ncurses
          # 如果你的 FHS 程序还有其他依赖，把它们添加在这里
        ]
      );
      profile = "export FHS=1";
      runScript = "zsh";
      extraOutputsToInstall = ["dev"];
    }))
      autotiling
      readline
      docker-compose
      gammastep
      gcc
      lazydocker
      libgcc
      SDL2
      openblas
      linuxHeaders
      linux-manual
      lm_sensors
      man-pages
      man-pages-posix
      ncurses
      ntfs3g
      wayland-utils
      waydroid
      vulkan-tools
      xsel
    ];
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
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
    yazi = {
      enable = true;

    };
    nix-ld = {
      enable=true;
      libraries=with pkgs;[
        gcc
	readline
	SDL2_mixer
	SDL2
      ];
    };
    waybar = {
      enable = true;
    };
    virt-manager = {
      enable = true;
    };
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
  services = {
    acpid = {
      enable = true;
      logEvents = true;
    };
    apache-kafka = {
      enable = true;
      settings = {
        "log.dirs" = ["/var/lib/apache-kafka"];
        "zookeeper.connect" = "localhost:2181";
      };
    };
    # aria2 = {
    #   enable = true;   
    #   rpcSecretFile = /run/secrets/aria2-rpc-token.txt;
    # };
    displayManager = {
      sddm = {
        enable = true;
	wayland.enable = true;
      };
    };
    distccd = {
      enable = true;  
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
    };
    # Enable CUPS to print documents.
    printing = {
      enable = true;
    };
    rabbitmq = {
      enable = true;
    };
    redis.servers = {
      logos = {
        enable = true;
      };
    };
    sunshine = {
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
    # Enable the X11 windowing system.
    xserver = {
      enable = true;
      windowManager = {
        i3 = {
          enable = true;
        };
      };
      # videoDrivers = [ "intel" ];
    };
    zookeeper = {
      enable = true;  
    };
  };

  systemd.services = {
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

  system.stateVersion = "24.11"; # Did you read the comment?

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";
  virtualisation = {
    waydroid = {
      enable = true;
    };
    docker = {
      enable = true;  
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
    firewall.interfaces."docker0".allowedTCPPorts = [ 7890 ];
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
