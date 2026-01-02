{
  pkgs,
  ...
}:
{
  imports = [
    ./gamescope.nix
    ./hyprland.nix
    ./sddm.nix
  ];
}
