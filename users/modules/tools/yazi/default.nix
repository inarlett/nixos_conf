{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    (inputs.nix-yazi-plugins.legacyPackages.x86_64-linux.homeManagerModules.default)
  ];
  programs = {
    yazi = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
    yazi.yaziPlugins = {
      enable = true;
      plugins = {
        bookmarks.enable = true;
        smart-enter.enable = true;
        starship.enable = true;
        jump-to-char = {
          enable = true;
          keys.toggle.on = [ "F" ];
        };
        relative-motions = {
          enable = true;
          show_numbers = "relative_absolute";
          show_motion = true;
        };
      };
    };
  };
}
