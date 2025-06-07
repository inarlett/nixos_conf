{
  pkgs,
  ...
}:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_6_14;
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
    kernelParams = [
      "amdgpu.dcdebugmask=0x10"
    ];

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
#  powerManagement = {
#    cpuFreqGovernor = "powersave";
#    powertop = {
#      enable = true;
#    };
#  };
  hardware = {
    cpu.amd.updateMicrocode = true;
    graphics = {
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
        amdvlk
        mesa
      ];
    };
  };
  imports = [
    (import ./modules/grub2-theme-uefi-grub.nix {
      efiSysMountPoint = "/efi";
      theme = "tela";
    })
    ./modules/hardware-common.nix
  ];
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];
  virtualisation.docker.storageDriver = "btrfs";
}
