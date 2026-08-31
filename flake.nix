{
  description = "test";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    aagl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, aagl, ... }: {
    nixosConfigurations.b360m-d2v = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./configuration.nix

        {
          imports = [
            aagl.nixosModules.default
          ];

          nix.settings = aagl.nixConfig;

          programs.anime-game-launcher.enable = true;
          programs.anime-games-launcher.enable = true;
          programs.honkers-railway-launcher.enable = true;
          programs.honkers-launcher.enable = true;
          programs.wavey-launcher.enable = true;
          programs.sleepy-launcher.enable = true;
        }
      ];
    };
  };
}

