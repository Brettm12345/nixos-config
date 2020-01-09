{ pkgs, ... }:
let
  flood = import ./flood.nix pkgs;
  bash = "/run/current-system/sw/bin/bash";
  chmod = "/run/current-system/sw/bin/chmod";
  peerPort = 40000;
  dhtPort = 41000;
  floodPort = 42000;
  workingDir = "/home/brett/var/rtorrent";
  rpcSocket = "${workingDir}/rtorrent.sock";
  session = "${workingDir}/rtorrent.dtach";
  pidFile = "${workingDir}/rtorrent.pid";
in {
  home-manager.users.brett.programs.rtorrent = {
    enable = true;
    settings = ''
      directory.default.set                 = /mnt/media/Downloads
      session.path.set                      = ${workingDir}
      network.scgi.open_local               = ${rpcSocket}
      throttle.global_down.max_rate.set_kb  = 9000
      throttle.global_up.max_rate.set_kb    = 500
      network.port_range.set                = ${toString peerPort}-${
        toString peerPort
      }
      network.port_random.set               = no
      protocol.encryption.set               = allow_incoming,try_outgoing,enable_retry
      trackers.use_udp.set                  = no
      protocol.pex.set                      = yes
      dht.mode.set                          = on
      dht.port.set                          = ${toString dhtPort}
      schedule2 = dht_add_node, 0, 0, "dht.add_node=router.bittorrent.com"
      schedule2 = scgi_set_permission, 0, 0, "execute.nothrow = ${chmod}, \"g+w,o=\", ${rpcSocket}"
      execute.nothrow = ${bash}, -c, (cat, "echo -n > ${pidFile} ", (system.pid))
    '';
  };
}
