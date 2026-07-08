{
  pkgs,
  inputs,
  system,
  ...
}: {
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    radare2
    opencode
    neovim
  ] ++ [
    inputs.llm-agents.packages.${system}.oh-my-opencode
  ];

  home.file = {
    ".config/opencode/skills" = {
      source = dotfiles/opencode/skills;
      recursive = true;
    };
    ".config/opencode/opencode.jsonc".source = dotfiles/opencode/opencode.jsonc;
    ".config/opencode/oh-my-openagent.jsonc".source = dotfiles/opencode/oh-my-openagent.jsonc;
    ".bash_profile".source = dotfiles/bash_profile;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
