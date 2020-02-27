{ pkgs, ... }: {
  services.picom = {
    enable = true;
    refreshRate = 60;
    fade = true;
    vSync = "opengl";
    fadeDelta = 1;
    fadeSteps = [ "0.07" "0.07" ];
    settings = { experimental-backends = true; };
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
