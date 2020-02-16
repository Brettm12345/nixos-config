{ ... }: {
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
