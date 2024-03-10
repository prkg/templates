{
  description = "simple c project template";
  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; };
  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" ];
      forAllSystems = f:
        nixpkgs.lib.genAttrs supportedSystems (system: f system);
      nixpkgsFor = forAllSystems (system:
        import nixpkgs {
          inherit system;
          overlays = [ self.overlay ];
        });
    in {
      overlay = final: prev: { };
      devShell = forAllSystems (system:
        let pkgs = nixpkgsFor.${system};
        in pkgs.mkShell {
          buildInputs = with pkgs; [
            gcc
            pkg-config
            m4
            libtool
            gnumake
            automake
            cmake
            autoconf
            checkmake
            ccls
            valgrind
            cbmc
            afl
          ];
          shellHook = ''
            set -a
            set +a
          '';
        });
    };
}
