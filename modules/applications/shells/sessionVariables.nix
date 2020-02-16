{ lib, ... }: {
  environment.sessionVariables = {
    EXA_ARGS = lib.concatStringsSep " " [ "-F" "--icons" ];
    PROJECTS = "$HOME/src/github.com";
    GITHUB_USERNAME = "brettm12345";
    PERSONAL = "$PROJECTS/$GITHUB_USERNAME";
    CONFIG = "$PERSONAL/nixos-config";
  };
}
