{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.lf ];
  home-manager.users.brett.xdg.configFile."lf/lfrc".text = ''
    set previewer ~/bin/preview
    map i $~/bin/preview $f | less -R
  '';
}
