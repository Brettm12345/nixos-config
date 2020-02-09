{ ... }:
let
  fuzzyConfig = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    defaultCommand =
      "dash -c 'git ls-tree -r --name-only HEAD 2> /dev/null || fd -H --type f --ignore-file $XDG_CONFIG_HOME/git/gitignore . $HOME'";
    defaultOptions = [
      "--preview='~/bin/fzf-preview {}'"
      "--height=40%"
      "--reverse"
      "--ansi"
      "--cycle"
      "--color='16,fg+:2,bg+:0,hl:4,hl+:4,prompt:4,pointer:8'"
    ];
  };
in {
  home-manager.users.brett.programs = {
    fzf = fuzzyConfig;
    skim = fuzzyConfig;
  };
}
