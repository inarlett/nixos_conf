{ pkgs, config, ... }:
{
  services.displayManager = {
    sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm;
      extraPackages = [
        pkgs.kdePackages.qtmultimedia
      ];
      theme = "sddm-astronaut-theme";
      wayland.enable = true;
    };
  };
  environment.systemPackages = with pkgs; [
    (sddm-astronaut.override {
      embeddedTheme = "pixel_sakura";
      themeConfig = {
        # TODO Update Theme Config
        # https://github.com/Keyitdev/sddm-astronaut-theme/blob/master/Themes/astronaut.conf
        ScreenWidth = 2880;
        ScreenHeight = 1800;
        FontSize=22;
        HideSystemButtons=false;
        HideLoginButton=false;
        blur = false;
      };
    })
  ];
}
