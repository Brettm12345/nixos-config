{ ... }: {
  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
    usePredictableInterfaceNames = false;
    useDHCP = false;
    interfaces.eth0.ipv4.addresses = [{
      address = "192.168.1.2";
      prefixLength = 24;
    }];
    defaultGateway = "192.168.1.1";
    nameservers = [ "1.1.1.1" ];
    hostName = "uwu";
  };
}
