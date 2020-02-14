{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [ any-nix-shell exa grc ];
    shellAliases = {
      o = "open-project";
      l = "${pkgs.exa}/bin/exa -F --icons --git-ignore -1";
      ls = "${pkgs.exa}/bin/exa -F --icons --git-ignore";
      ll = "${pkgs.exa}/bin/exa -F --icons -l --git -h --git-ignore";
      la = "${pkgs.exa}/bin/exa -F --icons -l --git -a -h -g";
      git = "${pkgs.gitAndTools.hub}/bin/hub";
    };
  };
  programs.command-not-found.enable = true;
  programs.fish = {
    enable = true;
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
    interactiveShellInit = ''
      set fish_color_autosuggestion "#5b6395"
      set fish_color_cancel -r
      set fish_color_command "#77e0c6" --bold
      set fish_color_comment "#7e8eda" --italics
      set fish_color_cwd cyan
      set fish_color_end magenta
      set fish_color_error red --bold
      set fish_color_escape "#89DDFF"
      set fish_color_match "#38456A" --bold
      set fish_color_operator "#89DDFF" --underline --bold
      set fish_color_param blue
      set fish_color_quote blue
      set fish_color_redirection "#8fd6ff"
      set fish_color_search_match --background=brblack
      set fish_color_status magenta
      set fish_color_user brred
      set fish_color_valid_path cyan --underline
      set fish_pager_color_completion white
      set fish_pager_color_description brblack
      set fish_pager_color_prefix yellow
    '';
  };
  home-manager.users.brett.programs.fish.enable = true;
}
