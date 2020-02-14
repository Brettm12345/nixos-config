{ pkgs, ... }: {
  environment.pathsToLink = [ "/share/zsh" ];
  programs.zsh.enable = true;
  home-manager.users.brett.programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    initExtraBeforeCompInit = ''
      source ~/.zinit/bin/zinit.zsh
    '';
    initExtra = (builtins.readFile ./config.zsh);
  };
}
