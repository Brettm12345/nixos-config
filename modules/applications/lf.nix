{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.lf ];
  home-manager.users.brett.xdg.configFile."lf/lfrc".text = ''
    set previewer ~/bin/preview
    map i $~/.config/lf/pv.sh $f | less -R
  '';
}
