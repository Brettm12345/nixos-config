{ pkgs, ... }: {
  home-manager.users.brett.services.compton = {
    enable = true;
    package = pkgs.compton-rounded-corners;
    refreshRate = 60;
    fade = true;
    backend = "xrender";
    vSync = "opengl-swc";
    fadeDelta = 1;
    fadeSteps = [ "0.07" "0.07" ];
    extraOptions = ''
      corner-radius = 6
      use-damage = true
      glx-no-stencil = true
    '';
    shadow = true;
    shadowOffsets = [ (-10) (-10) ];
    shadowOpacity = "0.22";
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
}
