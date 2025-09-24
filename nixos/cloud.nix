{ config, pkgs,lib, ... }:

{
  imports =
    [
      # 导入适用于云环境的基础配置
      <nixpkgs/nixos/modules/virtualisation/amazon-image.nix>
    ];

  # 1. 引导加载器设置
  # 必须指向虚拟磁盘，阿里云通常是 /dev/vda
  boot.loader.grub.device =lib.mkForce "/dev/vda";
  boot.loader.timeout = lib.mkForce 0;
  # 2. 文件系统
  # 根文件系统对应虚拟磁盘的第一个分区
  fileSystems."/" = {
    device = lib.mkForce "/dev/vda1";
    fsType = "ext4";
  };

  # 3. 启用Cloud-Init
  # 这是最关键的一步！Cloud-Init用于从阿里云元数据服务获取主机名、网络配置、SSH密钥等信息。
  services.cloud-init.enable = true;
  # 确保你的镜像里包含阿里云需要的数据源
  services.cloud-init.config = ''
    datasource:
      AliYun:
        metadata_urls: ["http://100.100.100.200/"]
    system_info:
      default_user:
        name: nixos
        gecos: NixOS user
        sudo: ["ALL=(ALL) NOPASSWD:ALL"]
        groups: [wheel]
        shell: ${pkgs.zsh}/bin/zsh
  '';

  # 4. 网络配置
  # 必须使用DHCP，以便从阿里云的VPC网络中自动获取IP
  networking.useDHCP = true;

  # 5. 开启SSH服务
  # 确保您能远程登录
  services.openssh.enable = true;
  # 建议禁用密码登录，仅使用密钥
  services.openssh.settings.PasswordAuthentication = false;

  # 6. 用户和SSH密钥
  # 预设一个用户，并填入你的SSH公钥，以便首次登录
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # for sudo
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEF/+97sAkpw/+7/col70fxDAKcumM1d+DgDNxeZ6pCi insnath@outlook.com" # 替换成你的SSH公钥
    ];
  };

  # 系统包中最好包含基础工具
  environment.systemPackages = with pkgs; [ vim git curl ];

  system.stateVersion = "24.11"; # 根据你的NixOS版本设置
}
