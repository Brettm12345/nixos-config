{ pkgs, config, ... }: {
  environment.pathsToLink = [ "/share/zsh" ];
  programs.zsh.enable = true;
  home-manager.users.brett.programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    initExtraBeforeCompInit = ''
      source ${pkgs.imports.zinit}/bin/zinit.zsh
    '';
    initExtra = ''
      zinit light zsh-users/zsh-autosuggestions
      zinit light hlissner/zsh-autopair
      zinit light ohmyzsh/ohmyzsh
      zinit ice wait as"completion" lucid
      zinit snippet OMZ::plugins/gitfast/_git

      zinit ice wait atinit"zpcompinit" lucid
      zinit light zdharma/fast-syntax-highlighting

      bindkey '^e' autosuggest-accept
    '';
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
