{
  description = "NixOS configuration";

  inputs = {
    #daeuniverse.url = "github:daeuniverse/flake.nix";
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    #grub2-themes.url = "github:vinceliuice/grub2-themes";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/feefc78";
    nixos-wsl = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/NixOS-WSL";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-25.05";

      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1&ref=refs/tags/v0.49.0";
    hy3 = {
      url = "github:outfoxxed/hy3?ref=hl0.49.0"; # where {version} is the hyprland release version
      # or "github:outfoxxed/hy3" to follow the development branch.
      # (you may encounter issues if you dont do the same for hyprland)
      inputs.hyprland.follows = "hyprland";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # stylix.url = "github:danth/stylix";
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      hyprland,
      hy3,
      hyprland-plugins,
      nur,
      ...
    }:
    let
      mkSystem = import ./lib/mksystem.nix {
        inherit inputs nixpkgs overlays;
      };
      overlays = [
        (import ./pkgs)
        inputs.emacs-overlay.overlays.default
        inputs.nur.overlays.default
      ];
    in
    {
      homeConfigurations."inf@inf-desktop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        modules = [
          hyprland.homeManagerModules.default

          {
            wayland.windowManager.hyprland = {
              enable = true;
              plugins = [ hy3.packages.x86_64-linux.hy3 ];
            };
          }
        ];
      };
      nixosConfigurations =
        mkSystem "logos-morph" {
          dpi = 169;
          hardware = "surface-pro-8";
          extraModules = [
            ./nixos/modules/libvirt-host-firewall.nix
            ./nixos/modules/localhost-http-proxy.nix
          ];
          nixos = "logos";
          system = "x86_64-linux";
          users = [
            "monad"
            "root"
            "wjc5197"
          ];
        }
        // mkSystem "thoth-vm" {
          hardware = "vm";
          extraModules = [
            ./nixos/modules/libvirt-guest-http-proxy.nix
          ];
          nixos = "thoth";
          system = "x86_64-linux";
          users = [
            "monad"
            "root"
          ];
        }
        // mkSystem "plasma-rm" {
          hardware = "removable";
          extraModules = [
            ./nixos/modules/fish
            ./nixos/modules/localhost-http-proxy.nix
            (
              { pkgs, ... }:
              {
                environment.systemPackages = with pkgs; [
                  gparted
                ];
              }
            )
          ];
          nixos = "plasma";
          system = "x86_64-linux";
          users = [
            "monad"
            "root"
          ];
        }
        // mkSystem "plasma-laptop" {
          hardware = "laptop";
          extraModules = [
            ./nixos/modules/zsh
            ./nixos/modules/localhost-http-proxy.nix
          ];
          nixos = "plasma";
          system = "x86_64-linux";
          users = [
            "monad"
            "root"
            "wjc5197"
          ];
        }
        // mkSystem "inf-desktop" {
          hardware = "mechrevo";
          extraModules = [
            ./nixos/modules/zsh
            ./nixos/modules/localhost-http-proxy.nix
          ];

          nixos = "nixos";
          system = "x86_64-linux";
          users = [
            "monad"
            "root"
            "inf"
          ];
        };
    };
}
