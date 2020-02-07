{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ any-nix-shell exa ];
  programs.command-not-found.enable = true;
  programs.fish = {
    enable = true;
    shellAliases = {
      l = "exa -F --git-ignore -1";
      ls = "exa -F --git-ignore";
      ll = "exa -l --git -h -F --git-ignore";
      la = "exa -F -l --git -a -h -g";
      git = "hub";
    };
    promptInit = ''
      any-nix-shell fish --info-right | source
      starship init fish | source
      set -x MANPAGER "nvim -c 'set ft=man' -"
      set -x BROWSER "${pkgs.chromium}/bin/chromium"
      set -x EDITOR "nvim"
      set -x NPM_DIR "$HOME/.npm/bin"
      set -U fish_user_paths "$HOME/bin" "$HOME/.cask/bin" "$HOME/.emacs.d/bin" "$NPM_DIR" "$CARGO_HOME/bin" "$HOME/.local/bin"
      source ${pkgs.imports.forgit}/forgit.plugin.fish
    '';
  };
  users.users.brett.shell = "/run/current-system/sw/bin/fish";
}
