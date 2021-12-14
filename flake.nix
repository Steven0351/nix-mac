{
  description = "My Nix Environment";

  nixConfig = {
    extra-substituters = [ 
      "https://cachix.cachix.org" 
      "https://nix-community.cachix.org"
    ];

    extra-trusted-public-keys = [
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpks.follows = "unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "unstable";
    };
    my-nixpkgs = {
      url = "github:Steven0351/nixpkgs-srs/main";
      inputs.nixpkgs.follows = "unstable";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }@inputs: {
    darwinConfigurations = {
      macbook = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          ({ pkgs, lib, ...}: {
            services.nix-daemon.enable = true;
            nixpkgs = {
              config.allowUnfree = true;
            };
            nix = {
              package = pkgs.nixUnstable;
              extraOptions = ''
                system = x86_64-darwin
                experimental-features = nix-command flakes 
                build-users-group = nixbld
              '';
            };
            environment.systemPackages = with pkgs; [
              ripgrep
            ];
          })
        ];   
      };
    };

    homeManagerConfigurations = {
      macbook = home-manager.lib.homeManagerConfiguration {
        configuration = {

          
          nixpkgs = {
            overlays = with inputs; [
              my-nixpkgs.overlay
            ];
            config.allowUnfree = true; 
          };

          imports = [ ./modules/home.nix ];
        };
        system = "x86_64-darwin";
        homeDirectory = "/Users/stevensherry";
        username = "stevensherry";
      };
    };
  };
}
