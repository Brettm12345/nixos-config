{ pkgs, lib, ... }:
let exa = "${pkgs.exa}/bin/exa";
in {
  environment.shellAliases = {
    o = "open-project";
    l = "${exa} --git-ignore -1";
    ls = "${exa} --git-ignore";
    ll = "${exa} -l --git -h --git-ignore";
    la = "${exa} -l --git -h -a -g";
    r = "exec $SHELL";
    rebuild = "$HOME/src/github.com/brettm12345/nixos-config/install";
    re = "rebuild";
  };
}
