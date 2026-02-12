{ config,dpi,pkgs,inputs, ... }:
{
  home = {
    homeDirectory = "/root";
    stateVersion = "25.05"; # Please read the comment before changing.
    username = "root";
  };
}
