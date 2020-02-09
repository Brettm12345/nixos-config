{ ... }: {
  boot = {
    plymouth.enable = true;
    loader = {
      efi.canTouchEfiVariables = false;
      grub = {
        efiSupport = true;
        efiInstallAsRemovable = true;
        gfxmodeEfi = "autl";
        gfxpayloadEfi = "keep";
        device = "nodev";
      };
    };
  };
}
