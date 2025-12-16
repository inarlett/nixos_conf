{
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    ccid
  ];
  services={
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
