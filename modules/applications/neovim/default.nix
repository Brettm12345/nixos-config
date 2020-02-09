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
        pluginDictionaries = [
          {
            names = [
              "moonlight"
              "vim-tmux"
              "vim-cool"
              "vim-tmux-navigator"
              "editorconfig-vim"
              "tmux-complete-vim"
              "vim-sleuth"
              "vim-endwise"
              "direnv-vim"
              "polyglot"
              "vim-surround"
              "vim-commentary"
              "vim-repeat"
              "vim-gitgutter"
            ];
          }
          {
            names = [ "jdaddy-vim" ];
            ft_regex = "^.json$";
          }
        ];
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
