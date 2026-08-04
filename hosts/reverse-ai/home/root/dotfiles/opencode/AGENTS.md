
You are running on a nixos linux distribution

If you encounter a missing package or "command not found"

You can search for the package of a binary with the following command:
```sh
nix run nixpkgs#nix-search-cli -- <binary name>
```

Then you can run a specific executable of a specific package with the following command:

```sh
nix shell nixpkgs#<package> -c <executable> <args...>
```

---

On this environment there is herdr running (tmux like, terminal multiplexer) that you can use to:
- Gain full interactive terminal
- Ask the user to spawn an elevated pane to elevate your privileges if needed for some action
- Interact or collaborate with the user on a shared panel

