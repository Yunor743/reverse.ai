---
name: nix-missing-command
description: Use when an executable is not found (command not found) and needs to be resolved via the NixOS package manager. Triggers on "command not found", missing binary errors, or when a desired CLI tool is not installed locally.
---

# Nix Missing Command

When you attempt to run an executable but receive a "command not found" error or the binary is not installed, resolve it using Nix without permanently installing anything.

## Two-step procedure

### Step 1 — Search for the package providing the executable

```
nix run nixpkgs#nix-search-cli -- <executable-name>
```

This searches the nixpkgs index and returns a list of packages along with the binaries they provide. Identify the package whose entry includes the executable you need (right side after the `:`).

Example output for `cowsay`:

```
cowsay @ 3.8.4 : cowsay cowthink
rPackages.cowsay @ 1.2.2
emacsPackages.cowsay @ 20210510.1540
cowsql @ 1.15.9
neo-cowsay @ 2.0.4 : cowsay cowthink
cowpatty @ 4.8 : cowpatty genpmk
```

Here `cowsay @ 3.8.4 : cowsay cowthink` tells us the package `cowsay` provides the `cowsay` binary.

### Step 2 — Run the package without installing it

```
nix run nixpkgs#<package-name> -- <parameters>
```

Use the exact `package-name` (the attribute before ` @`) from the search results, not the human-readable description.

Example:

```
nix run nixpkgs#cowsay -- hello
```

Output:

```
 _______
< hello >
 -------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```

## Rules

1. Always search first (Step 1) — never guess the package name.
2. If multiple packages provide the binary, prefer the top-level nixpkgs entry (not `rPackages.*`, `emacsPackages.*`, etc.).
3. If no package provides the binary, report this to the user and suggest alternatives.
4. Prefer `nix run` over `nix-shell -p` — it is faster and does not leave a persistent shell.
5. Keep the `nix run nixpkgs#nix-search-cli --` prefix exactly as shown; the `--` separates nix arguments from the search query.