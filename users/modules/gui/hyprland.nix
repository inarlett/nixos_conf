{
  config,
  inputs,
  pkgs,
  ...
}:

let
  modules_path_base = "${config.home.homeDirectory}/.nixos/users/modules";
  gui_path_base = "${modules_path_base}/gui";
  hyprland_path = "${gui_path_base}/hypr";
  waybar_path = "${gui_path_base}/waybar";
  wpaperd_path = "${gui_path_base}/wpaperd";
in
{
  home = {
    file = {
      ".config/hypr".source = config.lib.file.mkOutOfStoreSymlink hyprland_path;
      ".config/waybar".source = config.lib.file.mkOutOfStoreSymlink waybar_path;
      ".config/wpaperd".source = config.lib.file.mkOutOfStoreSymlink wpaperd_path;
    };
    packages = [
      #inputs.hy3.packages.x86_64-linux.hy3
    ];
    sessionVariables = {
      ANKI_WAYLAND = "1";
      QT_QPA_PLATFORM = "wayland";
    };
  };
  programs = {
    hyprlock = {
      enable = true;
    };
    wlogout = {
      enable = true;
      layout = [
        {
          label = "lock";
          action = "hyprlock";
          text = "Lock";
        }
        {
          label = "hibernate";
          action = "systemctl hibernate";
          text = "Hibernate";
        }
        {
          label = "logout";
          action = "hyprctl dispatch exit";
          text = "Logout";
        }
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Shutdown";
        }
        {
          label = "suspend";
          action = "systemctl suspend && hyprlock";
          text = "Sleep";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          text = "Reboot";
        }
      ]; 
    };
  };
  services = {
    hypridle = {
      enable = true;
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprscrolling
    ];
    extraConfig = ''
      source=${gui_path_base}/conf/hyprland.conf
    ''; 
  };
  
}
