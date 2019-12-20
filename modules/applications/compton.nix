{ ... }: {
  home-manager.users.brett = {
    # programs.autorandr.hooks.preswitch.compton = "systemctl --user stop compton";
    # programs.autorandr.hooks.postswitch.compton = "systemctl --user start compton";
    services.compton = {
      enable = true;
      backend = "glx";
      noDNDShadow = false;
      shadow = true;
      vSync = "opengl-swc";
    };
  };
}
