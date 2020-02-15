{ ... }:
let
  fuzzyConfig = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    defaultCommand =
      "git ls-tree -r --name-only HEAD 2> /dev/null || fd -H --type f . $HOME/src";

    defaultOptions = [
      "--height=70%"
      "--reverse"
      "--border"
      "--bind ctrl-a:select-all"
      "--bind ctrl-k:preview-up"
      "--bind ctrl-j:preview-down"
      "--bind ctrl-s:toggle-sort"
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
