{
  description = "sketch project";
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
        let
          pkgs = nixpkgsFor.${system};

          sbcl = pkgs.sbcl.withOverrides (self: super: {
            sdl2-image = pkgs.sbclPackages.sdl2-image.overrideLispAttrs
              (_: { nativeLibs = with pkgs; [ SDL2_image ]; });
            sdl2-ttf = pkgs.sbclPackages.sdl2-ttf.overrideLispAttrs
              (_: { nativeLibs = with pkgs; [ SDL2_ttf ]; });
            glu-tessellate = pkgs.sbclPackages.glu-tessellate.overrideLispAttrs
              (_: { nativeLibs = with pkgs; [ libGLU ]; });
            sketch = super.sketch.overrideLispAttrs (oldAttrs: {
              src = pkgs.fetchFromGitHub {
                owner = "vydd";
                repo = "sketch";
                rev = "master";
                hash = "sha256-1C6MstqZPohQQ9+e7fisSwkGxSYcNA01mfNzJZakAK8=";
              };
              lispLibs = with super; [
                closer-mop
                glkit
                self.glu-tessellate
                mathkit
                md
                self.sdl2
                cl-plus-c
                self.sdl2-image
                self.sdl2-ttf
                sdl2kit
                split-sequence
                static-vectors
                trivial-garbage
                zpng
              ];
            });
          });

        in pkgs.mkShell {
          buildInputs = with pkgs;
            [ (sbcl.withPackages (ps: with ps; [ sketch ])) ];
          shellHook = ''
            set -a
            export CL_SOURCE_REGISTRY="$(pwd)"
            set +a
          '';
        });
    };
}
