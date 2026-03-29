{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    yubikey-manager
  ];
  imports = [
    ./gpg.nix
  ];
}
