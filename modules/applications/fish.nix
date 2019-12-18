{ pkgs, config, ... }: {
  home-manager.users.brett = {
    programs.fish.enable = true;
    home.packages = with pkgs; [ exa ];
  };
  users.users.brett.shell = "${pkgs.fish}/bin/fish";
}
