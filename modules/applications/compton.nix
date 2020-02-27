{ pkgs, ... }: {
  home-manager.users.brett.services.compton = {
    enable = true;
    package = pkgs.compton-rounded-corners;
    refreshRate = 60;
    vSync = "opengl-swc";
    fade = true;
    fadeDelta = 1;
    fadeSteps = [ "0.01" "0.012" ];
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
