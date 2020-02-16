{ pkgs, config, lib, ... }: {
  programs.command-not-found.enable = true;
  environment = {
    systemPackages = with pkgs; [ any-nix-shell exa grc ];
    shellAliases = {
      o = "open-project";
      l = "${pkgs.exa}/bin/exa -F --icons --git-ignore -1";
      ls = "${pkgs.exa}/bin/exa -F --icons --git-ignore";
      ll = "${pkgs.exa}/bin/exa -F --icons -l --git -h --git-ignore";
      la = "${pkgs.exa}/bin/exa -F --icons -l --git -a -h -g";
      git = "${pkgs.gitAndTools.hub}/bin/hub";
      r = "exec $SHELL";
    };
  };
  users.users.brett.shell = "/run/current-system/sw/bin/zsh";
}
