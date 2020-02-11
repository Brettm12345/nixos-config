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

      plug.plugins = with plugins; [
        moonlight
        deoplete-nvim
        vim-tmux
        vim-fish
        vim-cool
        vim-tmux-navigator
        editorconfig-vim
        tmux-complete-vim
        vim-sleuth
        vim-vinegar
        vim-endwise
        vim-nix
        direnv-vim
        polyglot
        vim-surround
        vim-commentary
        fzf-vim
        nvim-yarp
        vim-repeat
        vim-gitgutter
        jdaddy-vim
      ];
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
