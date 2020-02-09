{ ... }: {
  boot = {
    loader = {
      grub = {
        efiSupport = true;
        efiInstallAsRemovable = true;
        gfxmodeEfi = "1280x1024";
        device = "/dev/nvme0n1p4";
      };
    };
  };
}
