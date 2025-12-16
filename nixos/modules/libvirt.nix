{
  lib,
  pkgs,
  ...
}:
{
  networking.firewall.trustedInterfaces = [
    "virbr0"
  ];
  systemd = {
    services = {
      libvirtd.wantedBy = lib.mkForce [ ];
      libvirt-guests.wantedBy = lib.mkForce [ ];
    };
  };
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        vhostUserPackages = with pkgs; [ virtiofsd ];
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
  };
}
