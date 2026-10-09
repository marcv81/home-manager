{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix-fork = {
      url = "github:marcv81/helix/marcv81";
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
