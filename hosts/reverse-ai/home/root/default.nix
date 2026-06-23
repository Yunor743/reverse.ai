{
  pkgs,
  ...
}: {
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    radare2
    opencode
    neovim
  ];

  home.file = {
    ".config/opencode/skills" = {
      source = dotfiles/opencode/skills;
      recursive = true;
    };
    ".config/opencode/opencode.jsonc".source = dotfiles/opencode/opencode.jsonc;
    ".bash_profile".source = dotfiles/bash_profile;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
