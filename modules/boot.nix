{ ... }: {
  boot = {
    plymouth.enable = true;
    loader = {
      efi.canTouchEfiVariables = false;
      grub = {
        efiSupport = true;
        efiInstallAsRemovable = true;
        gfxmodeEfi = "auto";
        gfxpayloadEfi = "keep";
        device = "nodev";
      };
    };
  };
}
