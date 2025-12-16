{
  lib,
  ...
}:
{
  networking.firewall = {
    trustedInterfaces = [
      "waydroid0"
    ];
    interfaces.waydroid0 = {
      allowedUDPPorts = [
        67
        53
      ]; # 允许 DHCP 和 DNS
    };
  };
  systemd = {
    services = {
      waydroid-container.wantedBy = lib.mkForce [ ];
    };
  };
  virtualisation = {
    waydroid = {
      enable = true;
    };
  };
}
