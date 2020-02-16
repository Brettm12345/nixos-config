{ pkgs, config, lib, ... }: {
  programs.command-not-found.enable = true;
  environment = {
    systemPackages = with pkgs; [ starship any-nix-shell exa grc ];
    shellAliases = {
      o = "open-project";
      l = "${pkgs.exa}/bin/exa -F --icons --git-ignore -1";
      ls = "${pkgs.exa}/bin/exa -F --icons --git-ignore";
      ll = "${pkgs.exa}/bin/exa -F --icons -l --git -h --git-ignore";
      la = "${pkgs.exa}/bin/exa -F --icons -l --git -a -h -g";
      git = "${pkgs.gitAndTools.hub}/bin/hub";
      r = "exec $SHELL";
    };
  };
  users.users.brett.shell = "/run/current-system/sw/bin/zsh";
  home-manager.users.brett.programs.starship = {
    enable = true;
    enableBashIntegration = true;
    disabled = [ "battery" ];
    symbols = {
      aws = " ";
      conda = " ";
      git_branch = " ";
      golang = " ";
      package = " ";
      python = " ";
    };
    styles.directory = "blue";
    settings = {
      character.style_success = "purple";
      nix_shell = {
        symbol = " ";
        use_name = true;
      };
      haskell = {
        symbol = " ";
        style = "purple";
      };
      rust = {
        symbol = " ";
        style = "208 bold";
      };
      git_status = {
        prefix = "";
        suffix = " ";
        style = "yellow";
      };
    };
  };
}
