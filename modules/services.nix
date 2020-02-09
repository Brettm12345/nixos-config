{ ... }: {
  services = {
    acpid.enable = true;
    accounts-daemon.enable = true;
    avahi.enable = true;
    irqbalance.enable = true;
    udisks2.enable = true;
    earlyoom.enable = true;
    upower.enable = true;
    tor = {
      enable = true;
      torsocks.enable = true;
      client = {
        enable = true;
        privoxy.enable = true;
        socksListenAddressFaster = "127.0.0.1:9063";
      };
    };
  };
}
