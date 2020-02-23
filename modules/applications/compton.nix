{ ... }: {
  home-manager.users.brett = {
    services.compton = {
      enable = true;
      extraOptions = ''
        sw-opti = true;
        xrender-sync-fence = true;
        fade-in-step = 0.03;
        fade-out-step = 0.03;
        # no-fading-openclose = true;
        fade-exclude = [ ];
        vsync = "opengl-swc";
        use-ewmh-active-win = true;
        shadow = true;
        no-dnd-shadow = true;
        no-dock-shadow = true;
        clear-shadow = true;
        shadow-radius = 7;
        shadow-offset-x = -7;
        shadow-offset-y = -7;
        shadow-opacity = 0.5;
        # shadow-red = 0.0;
        # shadow-green = 0.0;
        # shadow-blue = 0.0;
            '';
      backend = "glx";
      refreshRate = 60;
      fade = true;
      fadeDelta = 4;
      shadow = true;
      shadowExclude = [
        "_GTK_FRAME_EXTENTS@:c"
        "window_type *= 'menu'"
        "window_type = 'utility'"
        "window_type = 'popup_menu'"
        "window_type = 'dropdown_menu'"
        "class_g = 'dzen2'"
        "name    = 'dzen title'"
      ];
    };
  };
}
