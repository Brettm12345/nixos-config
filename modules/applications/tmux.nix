{ pkgs, ... }: {
  home-manager.users.brett.programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    baseIndex = 1;
    keyMode = "vi";
    shortcut = "p";
    aggressiveResize = true;
    historyLimit = 10000;
    reverseSplit = true;
    extraConfig = ''
      setw -gq utf8 on
      set-option -ga terminal-overrides ",xterm-termite:Tc"
      set-option -ga terminal-overrides ",xterm-256color:Tc"
      set-option -ga terminal-overrides ",tmux-256color:Tc"
      set-option -ga terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[2 q'
      set-option -ga terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[2 q'
      set -g set-titles on
      set -g set-titles-string "tmux [#H] #S:#W:#T"
      setw -g mouse on
      bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'copy-mode -e'"
      set -sg repeat-time 600
      unbind %
      unbind '"'
      bind s split-window -c "#{pane_current_path}" -v
      bind v split-window -c "#{pane_current_path}" -h
      bind c new-window -c "#{pane_current_path}"
      # break pane into a window
      bind = select-layout even-vertical
      bind + select-layout even-horizontal
      bind - break-pane
      bind _ join-pane

      # reload config without killing server
      bind ^r refresh-client

      # Smart pane switching with awareness of vim splits
      # See: https://github.com/christoomey/vim-tmux-navigator
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

      is_fzf="ps -o state= -o comm= -t '#{pane_tty}' \
        | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?fzf$'"

      is_sk="ps -o state= -o comm= -t '#{pane_tty}' \
        | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?sk$'"

      bind -n C-h run "($is_vim && tmux send-keys C-h) || \
                      tmux select-pane -L"

      bind -n C-j run "($is_vim && tmux send-keys C-j)  || \
                      ($is_fzf && tmux send-keys C-j) || \
                      ($is_sk && tmux send-keys C-j) || \
                      tmux select-pane -D"

      bind -n C-k run "($is_vim && tmux send-keys C-k) || \
                      ($is_fzf && tmux send-keys C-k)  || \
                      ($is_sk && tmux send-keys C-k)  || \
                      tmux select-pane -U"

      bind -n C-l run "($is_vim && tmux send-keys C-l) || \
                      tmux select-pane -R"
      bind C-w last-pane
      bind C-n next-window
      bind C-p previous-window
      bind n run 'TMUX= tmux new-session -t "$(basename \"$PWD\")" -d \; switch-client -t "$(basename \"$PWD\")"'
      bind N run 'TMUX= tmux new-session -t "$(tmux display-message -p #S)" -s "$(tmux display-message -p #S-clone)" -d \; switch-client -n \; display-message "session #S cloned"'
      bind | select-layout even-horizontal
      bind _ select-layout even-vertical

      # switch between sessions
      bind -r [ switch-client -p
      bind -r ] switch-client -n

      # Disable confirmation
      bind x kill-pane
      bind X kill-window
      bind q kill-session
      bind Q kill-server

      # Toggle the status bar
      bind-key b set-option status

      bind Enter copy-mode # enter copy mode
      bind p paste-buffer  # paste from the top pate buffer
      bind P choose-buffer # choose which buffer to paste from

      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi C-v send -X rectangle-toggle
      bind -T copy-mode-vi y send -X copy-pipe 'xclip -in -selection clipboard'
      bind -T copy-mode-vi Escape send -X cancel
      bind -T copy-mode-vi H send -X start-of-line
      bind -T copy-mode-vi L send -X end-of-line

      set -g status-position bottom
      set -g status-style 'background=default foreground=colour15'
      set -g status-interval 1
      set -g status-left ""
      set -g status-justify left
      set -g status-right '#{prefix_highlight} #[background=colour0,foreground=colour8] %l:%M %P #[background=default] #[background=colour0,foreground=colour8] #S '
      set -g status-right-length 40
      set -g status-left-length 40

      # The messages
      set -g message-style 'foreground=colour7 background=default'
      set -g message-command-style 'foreground=colour5 background=default'

      # loud or quiet?
      set-option -g visual-activity off
      set-option -g visual-bell off
      set-option -g visual-silence off
      set-window-option -g monitor-activity on
      set-option -g bell-action none

      # The modes
      setw -g clock-mode-style 'foreground=colour8 background=default'
      setw -g mode-style 'foreground=colour3 background=colour0'

      # The panes
      set -g pane-border-style 'background=default foreground=colour0'
      set -g pane-active-border-style 'background=default foreground=colour8'

      # Window status
      set -g window-status-format ' #(if [ #{pane_current_command} = "fish" ]; then basename #{pane_current_path}; elif [ #{pane_current_command} = "weechat" ]; then echo "#T"; elif [ #{pane_current_command} = "ncmpcpp" ]; then echo "#T"; elif [ #{pane_current_command} = "nvim" ]; then echo "#T"; else echo "#{pane_current_command}"; fi;) '
      set -g window-status-current-format ' #(if [ #{pane_current_command} = "fish" ]; then basename #{pane_current_path}; elif [ #{pane_current_command} = "weechat" ]; then echo "#T"; elif [ #{pane_current_command} = "ncmpcpp" ]; then echo "#T"; elif [ #{pane_current_command} = "nvim" ]; then echo "#T"; else echo "#{pane_current_command}"; fi;) '
      set -g window-status-separator " "
      set -g window-status-style 'foreground=colour8 background=colour0'
      set -g window-status-current-style 'foreground=colour7 background=colour0'
      setw -g window-status-activity-style 'foreground=default background=colour0'
      setw -g window-status-bell-style 'foreground=colour3 background=colour3 bright'
    '';
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
