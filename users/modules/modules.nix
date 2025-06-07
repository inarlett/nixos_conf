let
  modules_path_base = "${builtins.getEnv "HOME"}/.nixos/users/modules";
  gui_path_base = "${modules_path_base}/gui";
  tools_path_base = "${modules_path_base}/tools";
in
{
  modules_path_base = modules_path_base;
  gui_path_base = gui_path_base;
  tools_path_base = tools_path_base;

  hyprland_path = "${gui_path_base}/hypr";
  waybar_path = "${gui_path_base}/waybar";
  wpaperd_path = "${gui_path_base}/wpaperd";
  yazi_path = "${tools_path_base}/yazi";
}

