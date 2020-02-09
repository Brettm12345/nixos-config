{ ... }: {
  boot = {
    loader = {
      efi.canTouchEfiVariables = false;
      grub = {
        efiSupport = true;
        efiInstallAsRemovable = true;
        gfxmodeEfi = "1600x1200";
        device = "nodev";
      };
    };
  };
}
