{
  efiSysMountPoint,
}:
{ pkgs, lib, ... }: 
{
  environment.systemPackages = [
    # For debugging and troubleshooting Secure Boot.
    pkgs.sbctl
  ];

  boot.loader={
    efi = {
        canTouchEfiVariables = true;
        inherit efiSysMountPoint;
    };
    systemd-boot.enable = lib.mkForce false;
  };

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}
