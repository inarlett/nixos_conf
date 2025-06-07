{ config, pkgs, ... }:

let
  modules_path_base = "${config.home.homeDirectory}/.nixos/users/modules";
  tools_path_base = "${modules_path_base}/tools";
  yazi_path = "${tools_path_base}/yazi";
in
{
  home = {
    file = {
      ".config/yazi".source = config.lib.file.mkOutOfStoreSymlink yazi_path;
    };
  };
  imports = [
    ./nvim
  ];
}
