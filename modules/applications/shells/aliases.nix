{ pkgs }: {
  shellAliases = with pkgs; {
    o = "open-project";
    l = "${exa}/bin/exa -F --icons --git-ignore -1";
    ls = "${exa}/bin/exa -F --icons --git-ignore";
    ll = "${exa}/bin/exa -F --icons -l --git -h --git-ignore";
    la = "${exa}/bin/exa -F --icons -l --git -a -h -g";
    git = "${gitAndTools.hub}/bin/hub";
    r = "exec $SHELL";
  };
}
