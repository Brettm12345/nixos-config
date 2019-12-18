{ config, ... }: {
  systemd.coredump.enable = true;
  environment.sessionVariables = with config.defaultApplications.editor; {
    EDITOR = cmd;
    VISUAL = cmd;
    NIX_AUTO_RUN = "1";
  };
  services.atd.enable = true;
  home-manager.users.brett = {
    home = {
      activation."mimeapps-remove" = {
        before = [ "linkGeneration" ];
        after = [ ];
        data = "rm -f /home/brett/.config/mimeapps.list";
      };
    };
    services.gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };

    programs = let
      fuzzyConfig = {
        enable = true;
        defaultCommand =
          "dash -c 'git ls-tree -r --name-only HEAD 2> /dev/null || fd -H --type f --ignore-file $XDG_CONFIG_HOME/git/gitignore . $HOME'";
        defaultOptions = [
          "--cycle"
          "--color=16,fg+:2,background+:0,hl:4,hl+:4,prompt:4,pointer:8"
        ];
      };
    in {
      fzf = fuzzyConfig;
      skim = fuzzyConfig;
      command-not-found.enable = true;
    };
    systemd.user.startServices = true;
  };
}
