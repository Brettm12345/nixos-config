{ pkgs, config, ... }: {
  environment.pathsToLink = [ "/share/zsh" ];
  home-manager.users.brett.programs.zsh = {
    enable = true;
    autocd = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    plugins = [{
      name = "fast-syntax-highlighting";
      src = pkgs.fetchFromGitHub {
        owner = "zdharma";
        repo = "fast-syntax-highlighting";
        rev = "94b6b5b8e58aeecd7587a973dbe110a352d7314d";
        sha256 = "1lvq9qk0jz65swbghg4j08353z27v7nhd1r5i454y91s6w6n4b46";
      };
    }];
  };
}
