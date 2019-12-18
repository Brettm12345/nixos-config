{ pkgs, ... }: {
  home-manager.users.brett = {
    home.packages = with pkgs.gitAndTools; [ hub ];
    programs.git = {
      enable = true;
      userName = "brettm12345";
      userEmail = "brettmandler@gmail.com";
      signing = {
        key = "B511A07485FD1360";
        signByDefault = true;
      };
    };
  };
}
