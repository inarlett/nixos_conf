{ config, lib, pkgs, ... }: {
  programs.gpg = {
    enable = true;
    settings = {
      default-key="C2FFA530F93B503A5004BB9D07AF2E061CCBA034";
      keyserver = "hkps://keys.openpgp.org";
      keyserver-options = "auto-key-retrieve";
    };
    scdaemonSettings = {
      disable-ccid = true;
    };
  };

  services.gpg-agent = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    enableSshSupport = true;
    
  };

  home.file = lib.mkIf pkgs.stdenv.isDarwin {
    ".gnupg/gpg-agent.conf".text = ''
      enable-ssh-support
      pinentry-program ${lib.getExe pkgs.pinentry_mac}
    '';
  };
}

