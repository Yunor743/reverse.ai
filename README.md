
# Reverse.ai

Leveraging [microvm.nix](https://github.com/microvm-nix/microvm.nix) to provide a fast and simple malware reverse engineering environment

## One-liners

### On NixOS (with flakes)

```bash
nix run github:Yunor743/reverse.ai#reverse-ai
```

### On others *nix distros

```bash
sudo docker run -v $(pwd):/workspace -w /workspace --rm -it --device /dev/kvm --privileged nixos/nix nix run --extra-experimental-features 'nix-command flakes' github:Yunor743/reverse.ai#reverse-ai
```

The app boots the MicroVM headless and connects you via SSH on `localhost:2222` for a smooth interactive session.
Type `exit` to leave; the VM shuts down automatically.
Boot logs are kept under `$TMPDIR/reverse-ai-<pid>-boot.log` for debugging.

---

## Known issue
Running from a DrvFs path (`/mnt/c/...`) fails because UNIX domain sockets aren't supported on Windows filesystems.
**Workaround:** Run from a native Linux directory:

```bash
mkdir -p ~/tmp && cd ~/tmp
# then run the docker command
```

# TODO
- [ ] Add the following mcp : https://github.com/SEKOIA-IO/RePythonNET-MCP
- [ ] Add radare2 wth plugins (r2ai, r2ghidra)
- [ ] Install yara, yarax, yara-forge
- [ ] Install Capa
Behavior analysis
- [ ] kunai / chainsaw / hayabusa / zircolite / 
- [ ] emulators
  - speakeasy example -> https://auteqia.garden/posts/articles/maldev/early-bird-apc-injection/
