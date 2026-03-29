{
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    pam_u2f
    libu2f-host
    ccid
  ];
  services = {
    pcscd = {
      enable = true;
      plugins = [ pkgs.ccid ];
    };
    udev.packages = [ pkgs.yubikey-personalization ];
  };
  # gnupg is set by default in nixos-common.nix
  security.pam = {
    services = {
      login.u2fAuth = true;
      sudo.u2fAuth = true;
    };
    #yubico
    #    yubico = {
    #       enable = true;
    #       debug = true;
    #       mode = "challenge-response";
    #       id = [ "" ];
    #    };
  };

}
