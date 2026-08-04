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
    ".config/opencode" = {
      source = dotfiles/opencode;
      recursive = true;
    };
    ".bash_profile".source = dotfiles/bash_profile;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
