{ pkgs, ... }: {
  environment.shellAliases = with pkgs; {
    br = "${broot}/bin/broot -p";
    rg = "${ranger}/bin/ranger";
    t = "${tmux}/bin/tmux";
    p = "${xclip}/bin/xclip -selection clipboard -out";
    y = "${xclip}/bin/xclip -selection clipboard -in";
    m = "man";
    o = "open-project";
    l = "${exa}/bin/exa --icons --git-ignore -1";
    ls = "${exa}/bin/exa --icons --git-ignore";
    ll = "${exa}/bin/exa --icons -l --git -h --git-ignore";
    la = "${exa}/bin/exa --icons -l --git -h -a -g";
    na = "${niv}/bin/niv add";
    nb = "nix-build";
    ne = "nix-env";
    no = "nix-opt";
    ns = "nix-shell";
    nr = "nix repl <nixpkgs>";
    nq = "nix-query";
    nsq = "nix-shell -p $(nix-query)";
    ni = "nix-env -iA $(nix-query)";
    r = "exec $SHELL";
    re =
      "make -f $PROJECTS/brettm12345/nixos-config/Makefile -C $PROJECTS/brettm12345/nixos-config switch";
  };
}
