{ pkgs, lib, ... }:
let exa = "${pkgs.exa}/bin/exa $EXA_ARGS";
in {
  environment.shellAliases = {
    o = "open-project";
    l = "${exa} --git-ignore -1";
    ls = "${exa} --git-ignore";
    ll = "${exa} -l --git -h --git-ignore";
    la = "${exa} -l --git -a -h -g";
    r = "exec $SHELL";
    rebuild = "$CONFIG/install";
    re = "rebuild";
  };
}
