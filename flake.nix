{
  description = "certstream-server-go flake";
  inputs = {
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
  };
  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
  in {
    packages = forAllSystems (system: {
      default = nixpkgs.legacyPackages.${system}.buildGoModule rec {
        pname = "certstream-server-go";
        version = "1.7.0";

        src = nixpkgs.legacyPackages.${system}.fetchFromGitHub {
          owner = "d-Rickyy-b";
          repo = "certstream-server-go";
          rev = "v${version}";
          hash = "sha256-iA4kwhGvAkRL0cMCfo0mdQYUZbWk3Y8xdb7jjjTaRFM=";
        };

        vendorHash = "sha256-S5uF+i5Qsgi3M7B7LbO7CDO2GkWXn4X8wK/hgSSedHo=";

        ldflags = ["-s" "-w"];

        meta = {
          description = "Drop-in replacement for the certstream server by Calidog.";
          homepage = "https://github.com/d-Rickyy-b/certstream-server-go";
          changelog = "https://github.com/d-Rickyy-b/certstream-server-go/blob/${src.rev}/CHANGELOG.md";
          license = nixpkgs.legacyPackages.${system}.lib.licenses.mit;
          maintainers = with nixpkgs.legacyPackages.${system}.lib.maintainers; [x123];
          mainProgram = "certstream-server-go";
        };
      };
    });
  };
}
