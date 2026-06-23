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

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      root = import ./home/root;
    };
  };

  system.stateVersion = "25.05";

}

