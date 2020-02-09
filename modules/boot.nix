{ ... }: {
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        efiSupport = true;
        gfxmodeEfi = "1280x1024";
        device = "/dev/nvme0n1p4";
      };
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
      };
    };
  };
}
