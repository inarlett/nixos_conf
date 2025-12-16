{pkgs, config, ...}:
{
services.displayManager = {
      sddm = {
        enable = true;
        package = pkgs.kdePackages.sddm;
        extraPackages = [
          pkgs.kdePackages.qtmultimedia
        ];
        theme="sddm-theme";
        wayland.enable = true;
      };
    };
}
