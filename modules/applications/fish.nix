{ pkgs, ... }: {
  home-manager.users.brett = {
    programs.fish.enable = true;
    home.packages = with pkgs; [ any-nix-shell exa ];
  };
  users.users.brett.shell = "${pkgs.fish}/bin/fish";
}
