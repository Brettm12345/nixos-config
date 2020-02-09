{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ any-nix-shell exa grc ];
  programs.command-not-found.enable = true;
  programs.fish = {
    enable = true;
    shellAliases = {
      o = "open-project";
      l = "${pkgs.exa}/bin/exa -F --icons --git-ignore -1";
      ls = "${pkgs.exa}/bin/exa -F --icons --git-ignore";
      ll = "${pkgs.exa}/bin/exa -F --icons -l --git -h --git-ignore";
      la = "${pkgs.exa}/bin/exa -F --icons -l --git -a -h -g";
      git = "${pkgs.gitAndTools.hub}/bin/hub";
    };
    loginShellInit = ''
      set -U fish_greeting
      set -x NPM_DIR "$HOME/.npm/bin"
      set -U fish_user_paths "$HOME/bin" "$HOME/.cask/bin" "$HOME/.emacs.d/bin" "$NPM_DIR" "$HOME/.cargo/bin" "$HOME/.local/bin"
    '';
    promptInit = ''
      bind -M insert \co 'open-project'
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish  | source
      $HOME/.cargo/bin/starship init fish | source
      source ${pkgs.imports.forgit}/forgit.plugin.fish
    '';
  };
  home-manager.users.brett.programs.fish.enable = true;
  users.users.brett.shell = "/run/current-system/sw/bin/fish";
}
