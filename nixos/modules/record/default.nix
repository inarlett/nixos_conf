{
  config,
  inputs,
  pkgs,
  ...
}:
{
  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
    plugins = with pkgs; [
      obs-studio-plugins.obs-pipewire-audio-capture
      obs-studio-plugins.wlrobs
      obs-studio-plugins.obs-vaapi
      obs-studio-plugins.obs-livesplit-one
    ];
  };
}
