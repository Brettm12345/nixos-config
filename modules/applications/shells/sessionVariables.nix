{ ... }: {
  home-manager.users.brett.home.sessionVariables = {
    EXA_ARGS = "--icons -F";
    EXA_DETAILED_ARGS = "-l --git -h";
    PROJECTS = "$HOME/src/github.com";
    GITHUB_USERNAME = "brettm12345";
    PERSONAL = "$PROJECTS/$GITHUB_USERNAME";
    CONFIG = "$PERSONAL/nixos-config";
  };
}
