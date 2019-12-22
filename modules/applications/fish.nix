{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ any-nix-shell exa ];
  programs.command-not-found.enable = true;
  programs.fish = {
    enable = true;
    promptInit = ''
      any-nix-shell fish --info-right | source
      source ${pkgs.imports.forgit}/forgit.plugin.fish
    '';
  };
  users.users.brett.shell = "/run/current-system/sw/bin/fish";
}
