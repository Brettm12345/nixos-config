{ ... }: {
  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
    usePredictableInterfaceNames = false;
    hostName = "uwu";
    # defaultGateway = "192.168.1.1";
    # interfaces.eth0.ipv4.addresses = [{
    #   address = "192.168.1.2";
    #   prefixLength = 24;
    # }];
  };
}
