{ pkgs, config, ... }: {
  environment.pathsToLink = [ "/share/zsh" ];
  programs.zsh.enable = true;
  home-manager.users.brett.programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    initExtraBeforeCompInit = ''
      source ~/.zinit/bin/zinit.zsh
    '';
    initExtra = ''
      zinit ice wait"0a" compile'{src/*.zsh,src/strategies/*}' lucid
      zinit light zsh-users/zsh-autosuggestions

      zinit ice wait"0b" lucid
      zinit light hlissner/zsh-autopair

      zinit ice wait as"completion" lucid
      zinit snippet OMZ::plugins/gitfast/_git

      zinit light softmoth/zsh-vim-mode
      KEYTIMEOUT=5
      MODE_CURSOR_VICMD="block"
      MODE_CURSOR_VIINS="blinking bar"
      MODE_CURSOR_SEARCH="steady underline"

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
