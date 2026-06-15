{
  description = "Flake to build personal systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, unstable, ... } @ inputs:  
  let 
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      config = {
        allowUnfree = true;
      };
    };

    pkgsUnstable = import unstable {
      inherit system;

      config = {
        allowUnfree = true;
      };
    };
  in
  {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system pkgsUnstable; };

        modules = [ ./hosts/laptop/configuration.nix ];
      };
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system pkgsUnstable; };

        modules = [ ./hosts/desktop/configuration.nix ];
      };
      cube = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system pkgsUnstable; };

        modules = [ ./hosts/cube/configuration.nix ];
      };
    };
  };
}
