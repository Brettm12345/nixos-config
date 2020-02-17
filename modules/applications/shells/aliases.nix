{ pkgs, lib, ... }:
let exa = "${pkgs.exa}/bin/exa $EXA_ARGS";
in {
  environment.shellAliases = {
    o = "open-project";
    l = "${exa} --git-ignore -1";
    ls = "${exa} --git-ignore";
    ll = "${exa} $EXA_DETAILED_ARGS --git-ignore";
    la = "${exa} $EXA_DETAILED_ARGS -a -g";
    r = "exec $SHELL";
    rebuild = "$HOME/src/github.com/brettm12345/nixos-config/install";
    re = "rebuild";
  };
}
