{ ... }: {
  home-manager.users.brett.home.sessionVariables = {
    PROJECTS = "$HOME/src/github.com";
    GITHUB_USERNAME = "brettm12345";
    PERSONAL = "$PROJECTS/$GITHUB_USERNAME";
    CONFIG = "$PERSONAL/nixos-config";
  };
}