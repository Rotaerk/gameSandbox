{
  description = "A sandbox for tinkering with making a game in Haskell.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      hs = pkgs.haskellPackages;
      GameSandbox = hs.callCabal2nix "GameSandbox" ./GameSandbox {};
    in {

      packages.x86_64-linux = {
        inherit GameSandbox pkgs;

        default = hs.shellFor {
          packages = p: [ ];
          nativeBuildInputs =
            (with hs; [
              cabal-install
              haskell-language-server
            ]) ++
            (with pkgs; [
              pkg-config # Used by cabal to find SDL2
              SDL2
            ]);
        };
      };
    };
}
