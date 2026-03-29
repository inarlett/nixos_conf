{
  lib,
  pkgs,
  ...
}:
{
  environment = {
    systemPackages = with pkgs; [
      docker-compose
      lazydocker
    ];
  };
  networking.firewall.trustedInterfaces = [
    "docker0"
  ];
  systemd = {
    services = {
      docker.wantedBy = lib.mkForce [ ];
    };
  };
  virtualisation = {
    docker = {
      enable = true;
      #      rootless = {
      #        enable = true;
      #        setSocketVariable = true;
      #      };
    };
  };
}
