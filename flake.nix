{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    microvm.url = "github:microvm-nix/microvm.nix";
    r2mcp-nix = {
      url = "github:Yunor743/radare2-mcp.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, microvm, ... } @ inputs :
    let
      system = "x86_64-linux";
      reverse-ai = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs nixpkgs system; };
        modules = [
          microvm.nixosModules.microvm
          inputs.home-manager.nixosModules.home-manager
          inputs.r2mcp-nix.nixosModules.default
          ./hosts/reverse-ai
        ];
      };
    in {
      nixosConfigurations.reverse-ai = reverse-ai;
      apps.${system}.reverse-ai = {
        type = "app";
        program = "${reverse-ai.config.microvm.runner.qemu}/bin/microvm-run";
      };
    };
}
