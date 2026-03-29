# /home/inf/.nixos/nixos/modules/rocm.nix
{
  config,
  pkgs,
  lib,
  ...
}:
{
  nixpkgs.config.cudaSupport = false;
}
