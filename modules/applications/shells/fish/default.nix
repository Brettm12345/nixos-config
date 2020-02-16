{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    loginShellInit = ''
      set -U fish_greeting
      set -x NPM_DIR "$HOME/.npm/bin"
      set -U fish_user_paths "$HOME/bin" "$HOME/.cask/bin" "$HOME/.emacs.d/bin" "$NPM_DIR" "$HOME/.cargo/bin" "$HOME/.local/bin"
    '';
    promptInit = with pkgs; ''
      bind -M insert \co 'open-project'
      ${any-nix-shell}/bin/any-nix-shell fish  | source
      $HOME/.cargo/bin/starship init fish | source
      source ${imports.forgit}/forgit.plugin.fish
    '';
    interactiveShellInit = builtins.readFile ./colors.fish;
  };
  home-manager.users.brett.programs.fish.enable = true;
}
