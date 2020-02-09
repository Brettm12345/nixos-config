{ ... }: {
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        efiSupport = true;
        gfxmodeEfi = "1280x1024";
        device = "nodev";
      };
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
      };
    };
  };
}
