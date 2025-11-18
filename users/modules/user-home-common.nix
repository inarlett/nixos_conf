{
  pkgs,
  inputs,
  ...
}:
{
  imports=[
    inputs.zen-browser.homeModules.beta
  ];
  home = {
    packages = with pkgs; [
      brightnessctl
      btop
      fastfetch
      fd
      gdb
      gitFull
      mupdf
      nixfmt-rfc-style
      nmap
      p7zip
      rr
      ripgrep
      tree
      wget
      units
      unzip
      volume
      xdg-utils
    ];
    sessionVariables = {
      EDITOR = "nvim";
      
    };
  };
  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
	  (fcitx5-rime.override {
            rimeDataPkgs = with pkgs; [
              rime-data
              rime-ice
            ];
          })
          fcitx5-with-addons
          fcitx5-configtool
          fcitx5-gtk
          kdePackages.fcitx5-qt
        ];
      };
    };
  };
  programs = {
    feh = {
      enable = true;  
    };
#    git = {
#      delta = {
#        enable = true;  
#      };
#      enable = true;
#    };
    mpv = {
      enable = true;  
    };
    zen-browser.enable = true;
  };
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
    };
  };
}
