{ pkgs, config, ... }: {
  environment.pathsToLink = [ "/share/zsh" ];
  home-manager.users.brett.programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    shellAliases = { "rebuild" = "sudo nixos-rebuild switch"; };
  };
}
