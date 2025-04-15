{
  pkgs,
  ...
}:
{
  boot = {
    extraModulePackages = [ ];
    kernelModules = [ ];
    initrd = {
      availableKernelModules = [
        "ahci"
        "nvme"
        "sd_mod"
        "sr_mod"
        "thunderbolt"
        "xhci_pci"
      ];
      kernelModules = [
	"amdgpu"
	"kvm_amd"
      ];
    };
  };
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
    };
    "/efi" = {
      device = "/dev/disk/by-label/efi";
      fsType = "vfat";
    };
  };
  hardware.graphics={
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      amdvlk
      mesa
    ];
  };
  imports = [
    (import ./modules/grub2-theme-uefi-grub.nix {
      efiSysMountPoint = "/efi";
      theme = "tela";
    })
    ./modules/hardware-common.nix
  ];
}
