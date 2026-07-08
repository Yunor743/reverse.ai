{
  config,
  nixpkgs,
  system,
  pkgs,
  ...
}: {
  imports = [
    ./microvm.nix
  ];

  networking.hostName = "reverse-ai";

  systemd.tmpfiles.rules = [
    "d /nix/.rw-store/nix-build 0755 root root -"
  ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      sandbox = false;
      build-dir = "/nix/.rw-store/nix-build";
    };
    registry.nixpkgs.flake = nixpkgs;
  };

  networking.firewall.allowedTCPPorts = [ 22 ];

  services.getty.autologinUser = "root";
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };
  services.r2mcp.enable = true;

  environment.systemPackages = with nixpkgs.legacyPackages.${system}; [
    # nix
    git
    pkg-config
    herdr
  ];

  users.users.root = {
    initialPassword = "weakpass";
  };

}

