{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ any-nix-shell exa grc ];
  programs.command-not-found.enable = true;
  programs.fish = {
    enable = true;
    shellAliases = {
      l = "${pkgs.exa}/bin/exa -F --icons --git-ignore -1";
      ls = "${pkgs.exa}/bin/exa -F --icons --git-ignore";
      ll = "${pkgs.exa}/bin/exa -F --icons -l --git -h --git-ignore";
      la = "${pkgs.exa}/bin/exa -F --icons -l --git -a -h -g";
      git = "${pkgs.gitAndTools.hub}/bin/hub";
    };
    loginShellInit = ''
      set -U fish_greeting
      set -x MANPAGER "${pkgs.neovim}/bin/nvim -c 'set ft=man' -"
      set -x BROWSER "${pkgs.chromium}/bin/chromium"
      set -x EDITOR "${pkgs.neovim}/bin/nvim"
      set -x NPM_DIR "$HOME/.npm/bin"
      set -U fish_user_paths "$HOME/bin" "$HOME/.cask/bin" "$HOME/.emacs.d/bin" "$NPM_DIR" "$CARGO_HOME/bin" "$HOME/.local/bin"
    '';
    promptInit = ''
      ${pkgs.direnv}/bin/direnv hook fish | source
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      # ${pkgs.starship}/bin/starship init fish | source
      $HOME/.cargo/bin/starship init fish | source
      source ${pkgs.imports.forgit}/forgit.plugin.fish
    '';
  };
  users.users.brett.shell = "/run/current-system/sw/bin/fish";
}
