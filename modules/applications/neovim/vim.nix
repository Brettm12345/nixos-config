with import <nixos>;
vim_configurable.customize {
  name = "vim";
  vimrcConfig = {
    vam = {
      knownPlugins = pkgs.vimPlugins;
      pluginDictionaries = [
        {
          names = [
            "direnv-vim"
            "vim-surround"
            "vim-commentary"
            "vim-repeat"
            "vim-gitgutter"
          ];
        }
        {
          name = "vim-addon-nix";
          ft_regex = "^nix$";
        }
      ];
    };
  };
}
