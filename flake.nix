{
  description = "Python application flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        pyPkgs = pkgs.python3Packages;
        lib = pkgs.lib;
      in {
        packages.default = pyPkgs.buildPythonPackage rec {
          pname = "selectolax";
          version = "0.3.28";
          pyproject = true;
          src = ./.;

          build-system = [pyPkgs.setuptools pyPkgs.cython];

          # nativeCheckInputs = [pyPkgs.pytestCheckHook];
          #
          # pythonImportsCheck = ["selectolax"];

          doCheck = false;

          meta = {
            description = "Python binding to Modest and Lexbor engines (fast HTML5 parser with CSS selectors).";
            homepage = "https://github.com/rushter/selectolax";
            changelog = "https://github.com/rushter/selectolax/releases/tag/${version}";
            license = lib.licenses.mit;
            maintainers = [lib.maintainers.octvs];
          };
        };
        devShells.default = pkgs.mkShell {buildInputs = [pkgs.python3 pyPkgs.setuptools pyPkgs.cython pyPkgs.pytest pyPkgs.pytestCheckHook];};
      }
    );
}
