{
  efiSysMountPoint,
  customResolution ? null,
  theme
}:
{
  inputs,
  ...
}:
{
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        inherit efiSysMountPoint;
      };
      limine = {
        device = "nodev";
        efiSupport = true;
        # font = "${pkgs.iosevka}/share/fonts/truetype/Iosevka-Regular.ttf";
        # fontSize = 31;
        # gfxmodeEfi = "2880x1920";
      };
      
    };
  };
}
