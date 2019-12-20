{ pkgs, ... }: {
  home-manager.users.brett.programs.tmux = with builtins; {
    enable = true;
    terminal = "tmux-256color";
    baseIndex = 1;
    keyMode = "vi";
    shortcut = "p";
    aggressiveResize = true;
    historyLimit = 10000;
    reverseSplit = true;
    extraConfig = readFile ./tmux.conf + readFile ./tmux.theme.conf;
    plugins = with pkgs.tmuxPlugins; [
      sessionist
      copycat
      yank
      open
      {
        plugin = continuum;
        extraConfig = "set -g @continuum-restore 'on'";
      }
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim "session"
          set -g @resurrect-capture-pane-contents "on"
        '';
      }
      {
        plugin = prefix-highlight;
        extraConfig = ''
          set -g @prefix_highlight_prefix_prompt "Wait"
          set -g @prefix_highlight_foreground "colour4"
          set -g @prefix_highlight_background 'colour0'
          set -g @prefix_highlight_output_suffix ""
          set -g @prefix_highlight_empty_attr "foreground=colour8,background=colour0"
          set -g @prefix_highlight_empty_prompt " Tmux "
          set -g @prefix_highlight_show_copy_mode "on"
          set -g @prefix_highlight_copy_prompt "Copy"
          set -g @prefix_highlight_copy_mode_attr "foreground=colour3,background=colour0"
        '';
      }
    ];
  };
}
