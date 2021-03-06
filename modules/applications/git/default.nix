{ pkgs, ... }: {
  home-manager.users.brett = {
    home.packages = with pkgs.gitAndTools; [ hub delta ];
    programs.git = {
      enable = true;
      userName = "brettm12345";
      userEmail = "brettmandler@gmail.com";
      signing = {
        key = "B511A07485FD1360";
        signByDefault = true;
      };
      includes = [{ path = "./colors.ini"; }];
      ignores = import ./ignore.nix;
      aliases = import ./aliases.nix;
      extraConfig = {
        core = {
          fileMode = false;
          quotepath = false;
          pager = "~/.cargo/bin/delta --theme Material-Theme-Palenight";
          whitespace = "trailing-space";
          patch = "!git --no-pager diff --no-color";
          autocrlf = false;
          eol = "LF";
        };
        ghq.root = "~/src";
        github.user = "Brettm12345";
        hub.protocol = "ssh";
        help.autocorrect = 1;
        push.default = "current";
        pull.rebase = true;
        rebase.autoStash = true;
      };
    };
  };
}
