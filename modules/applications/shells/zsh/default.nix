{ pkgs, ... }:
with builtins; {
  environment.pathsToLink = [ "/share/zsh" ];
  programs.zsh = {
    enable = true;
    enableGlobalCompInit = false;
  };
  home-manager.users.brett = {
    programs.zsh = {
      enable = true;
      autocd = true;
      enableCompletion = false;
      initExtraBeforeCompInit = ''
        source ~/.zinit/bin/zinit.zsh
      '';
      initExtra = ''
        ${readFile ./instant-prompt.zsh}
        ${readFile ./fast-zcompinit.zsh}
        ${readFile ./util.zsh}
        ${readFile ./hoc.zsh}
        ${readFile ./config.zsh}
        ${readFile ./completion.zsh}
      '';
    };
    xdg.configFile."zsh/p10k.zsh".text = readFile ./p10k.zsh;
    xdg.configFile."fsh/overlay.ini".text = readFile ./moonlight.ini;
  };
}
