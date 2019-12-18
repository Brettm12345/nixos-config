{ pkgs, ... }: {
  services.lorri.enable = true;
  home-manager.users.brett.home.packages = with pkgs; [ niv nixfmt ];
}
