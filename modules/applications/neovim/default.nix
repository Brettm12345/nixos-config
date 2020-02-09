{ pkgs, lib, ... }:
let
  plugins = with pkgs.imports;
    {
      moonlight = pkgs.vimUtils.buildVimPlugin {
        name = "moonlight";
        src = moonlight-vim;
      };
    } // pkgs.vimPlugins;
  mynvim = (pkgs.neovim.override {
    configure = {
      customRC = builtins.readFile ./init.vim;
      vam = {
        knownPlugins = plugins;
        pluginDictionaries = [{
          names = [
            "moonlight"
            "direnv-vim"
            "vim-surround"
            "vim-commentary"
            "vim-repeat"
            "vim-gitgutter"
          ];
        }];
      };
    };
  });
in with lib; {
  home-manager.users.brett = {
    home = {
      packages = with pkgs; [ mynvim ];
      sessionVariables.MANPAGER = "${mynvim}/bin/nvim -c 'set ft=man' -";
    };
  };
}
