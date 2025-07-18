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
        version = "1.8.1";

        src = nixpkgs.legacyPackages.${system}.fetchFromGitHub {
          owner = "d-Rickyy-b";
          repo = "certstream-server-go";
          rev = "v${version}";
          hash = "sha256-ashuwJjWrKjVtjPzBLmXX7EMFX0nlxs4B53pBP2G3Bo=";
        };

        vendorHash = "sha256-+7wL6JA5sNRNJQKelVkEVCZ5pqOlmn8o7Um2g6rsIlc=";

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
