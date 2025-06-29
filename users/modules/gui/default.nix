{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./utils
    ./xdg
  ];
}
