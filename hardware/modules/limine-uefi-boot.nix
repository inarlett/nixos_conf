{

  efiSysMountPoint,
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
        enable=true;
        secureBoot.enable=true;
        #biosDevice = if efi then "nodev" else "/dev/disk/by-id//dev/disk/by-id/nvme-WD_Green_SN350_1TB_241328801823-part7";
        efiSupport = true;
        efiInstallAsRemovable = true;
        maxGenerations = 32;
        # font = "${pkgs.iosevka}/share/fonts/truetype/Iosevka-Regular.ttf";
        # fontSize = 31;
        # gfxmodeEfi = "2880x1920";
      };
      timeout=2;
      
    };
  };
}
