{ ... }: {
  home-manager.users.brett = {
    services.compton = {
      enable = true;
      extraOptions = ''
        sw-opti = true;
        xrender-sync-fence = true;
        fade-in-step = 0.03;
        fade-out-step = 0.03;
        vsync = "opengl-swc";
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
