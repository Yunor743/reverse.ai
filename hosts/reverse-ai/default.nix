{
  config,
  inputs,
  nixpkgs,
  system,
  ...
}: {
  imports = [
    ./system
  ];

  nixpkgs.overlays = [ inputs.llm-agents.overlays.default ];

  home-manager = {
    extraSpecialArgs = {inherit inputs system;};
    users = {
      root = import ./home/root;
    };
  };

  system.stateVersion = "25.05";

}

