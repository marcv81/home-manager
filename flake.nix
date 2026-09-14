{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/abec4804aa876d4d80467d71d4727bf81c19e1c9";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix-fork = {
      url = "github:marcv81/helix/hardware-block-cursor-v2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixgl,
      helix-fork,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      homeConfigurations = {
        user = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit nixgl helix-fork; };
          modules = [ ./home.nix ];
        };
      };
    };
}
