{ ... }: {
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        efiSupport = true;
        gfxmodeEfi = "1280x1024";
        device = "/dev/nvme0n1";
      };
    };
  };
}
