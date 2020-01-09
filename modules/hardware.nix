{ ... }: {
  hardware = {
    sane.enable = true;
    logitech = {
      enable = true;
      enableGraphical = true;
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = false;
    };
  };
}
