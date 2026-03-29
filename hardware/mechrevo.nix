{
  config,
  pkgs,
  inputs,
  ...
}:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    kernelModules = [
      "v4l2loopback"
    ];
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
      "amdgpu.dc=1"
      "amdgpu.ppfeaturemask=0xffffffff"
      "amdgpu.dcdebugmask=0x10"
      "amdgpu.runpm=0"
      "amdgpu.cwsr_enable=0"
      "amdgpu.gpu_recovery=1"
      "amdgpu.lockup_timeout=10000"
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
        libva
        mesa
        vulkan-loader
        rocmPackages.clr.icd
      ];
    };
  };
  imports = [
    (import ./modules/grub2-theme-uefi-grub.nix {
      efiSysMountPoint = "/efi";
      theme = "tela";
    })
    #    (import ./modules/limine-uefi-boot.nix {
    #      efiSysMountPoint = "/efi";
    #    })
    #    (import ./modules/lanzaboote.nix{
    #      efiSysMountPoint = "/efi";
    #    })
    inputs.lanzaboote.nixosModules.lanzaboote

    ./modules/hardware-common.nix
  ];
  zramSwap.enable = true;
  zramSwap.memoryPercent = 80;
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];
  virtualisation.docker.storageDriver = "btrfs";
}
