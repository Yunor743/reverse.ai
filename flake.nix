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
      pkgs = nixpkgs.legacyPackages.${system};
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
      runner = reverse-ai.config.microvm.runner.qemu;
      reverse-ai-run = pkgs.writeShellApplication {
        name = "reverse-ai-run";
        runtimeInputs = [ pkgs.openssh pkgs.sshpass pkgs.netcat-openbsd pkgs.coreutils ];
        text = ''
          set -u
          SSH_PORT=2222
          PASSWORD="weakpass"
          LOG="''${TMPDIR:-/tmp}/reverse-ai-$$-boot.log"
          RUNNER="${runner}/bin/microvm-run"
          SHUTDOWN="${runner}/bin/microvm-shutdown"

          cleanup() {
            if timeout 30 "$SHUTDOWN" >/dev/null 2>&1; then return; fi
            kill "$VM_PID" 2>/dev/null || true
            wait "$VM_PID" 2>/dev/null || true
          }
          trap cleanup EXIT
          trap 'exit 130' INT
          trap 'exit 143' TERM
          trap 'exit 129' HUP

          echo "[reverse-ai] Starting VM headless (boot logs: $LOG)"
          "$RUNNER" </dev/null >"$LOG" 2>&1 &
          VM_PID=$!

          echo "[reverse-ai] Waiting for SSH on port $SSH_PORT..."
          ready=0
          attempts=180
          while [ "$attempts" -gt 0 ]; do
            attempts=$((attempts - 1))
            if nc -z -w1 127.0.0.1 "$SSH_PORT" 2>/dev/null; then
              if sshpass -p "$PASSWORD" ssh -p "$SSH_PORT" \
                  -o ConnectTimeout=2 -o StrictHostKeyChecking=no \
                  -o UserKnownHostsFile=/dev/null -o LogLevel=ERROR \
                  root@127.0.0.1 true 2>/dev/null; then
                ready=1; break
              fi
            fi
            sleep 1
          done

          if [ "$ready" != 1 ]; then
            echo "[reverse-ai] VM unreachable via SSH after 180s. Boot log:" >&2
            cat "$LOG" >&2 || true
            exit 1
          fi

          echo "[reverse-ai] Connected. Spawning interactive SSH session (type 'exit' to stop the VM)..."
          sshpass -p "$PASSWORD" ssh -p "$SSH_PORT" \
            -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
            -o ServerAliveInterval=30 -o LogLevel=ERROR \
            root@127.0.0.1
        '';
      };
    in {
      nixosConfigurations.reverse-ai = reverse-ai;
      apps.${system}.reverse-ai = {
        type = "app";
        program = "${reverse-ai-run}/bin/reverse-ai-run";
      };
    };
}
