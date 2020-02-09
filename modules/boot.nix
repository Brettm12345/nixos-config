{ ... }: {
  boot = {
    plymouth.enable = true;
    loader = {
      efi.canTouchEfiVariables = false;
      grub = {
        efiSupport = true;
        efiInstallAsRemovable = true;
        gfxmodeEfi = "1280x1024";
        gfxpayloadEfi = "keep";
        device = "nodev";
      };
    };
  };
}
