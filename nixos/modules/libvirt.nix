{
  lib,
  pkgs,
  ...
}:
{
  networking.firewall.trustedInterfaces = [
    "virbr0"
  ];
  environment = {
    systemPackages = with pkgs; [
      gvfs
      swtpm
      virglrenderer
    ];
  };
  systemd = {
    services = {
      libvirtd.wantedBy = lib.mkForce [ ];
      libvirt-guests.wantedBy = lib.mkForce [ ];
    };
  };
  services.spice-vdagentd.enable=true;
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
