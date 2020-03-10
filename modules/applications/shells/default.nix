{ pkgs, ... }:
let current = "zsh";
in {
  imports = [
    ./aliases.nix
    ./sessionVariables.nix
    # ./starship.nix
    ./fish
    ./zsh
  ];
  programs.command-not-found.enable = true;
  home-manager.users.brett.programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = false;
  };
  environment.systemPackages = with pkgs; [ any-nix-shell exa grc ];
  users.users.brett.shell = "/run/current-system/sw/bin/${current}";
}
