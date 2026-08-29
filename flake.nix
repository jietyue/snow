{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
   
  outputs = { self, nixpkgs }: {
    nixosConfigurations.b360m-d2v = nixpkgs.lib.nixosSystem {
    modules = [ ./configuration.nix ];
    };
  }; 
}
