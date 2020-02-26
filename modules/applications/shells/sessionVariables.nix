{ ... }: {
  home-manager.users.brett.home.sessionVariables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    PROJECTS = "$HOME/src/github.com";
    GITHUB_USERNAME = "brettm12345";
    PERSONAL = "$PROJECTS/$GITHUB_USERNAME";
    CONFIG = "$PERSONAL/nixos-config";
  };
}
