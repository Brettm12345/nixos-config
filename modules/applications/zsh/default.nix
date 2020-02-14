{ pkgs, ... }:
with builtins; {
  environment.pathsToLink = [ "/share/zsh" ];
  programs.zsh.enable = true;
  home-manager.users.brett.programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    initExtraBeforeCompInit = ''
      source ~/.zinit/bin/zinit.zsh
    '';
    initExtra = ''
      ${readFile ./config.zsh}
      ${readFile ./completion.zsh}
    '';
  };
  home-manager.users.brett.xdg.configFile."fsh/overlay.ini".text =
    readFile ./moonlight.ini;
  users.users.brett.shell = "/run/current-system/sw/bin/zsh";
}
