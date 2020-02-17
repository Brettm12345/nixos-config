{ ... }:

{
  imports = [
    (builtins.fetchTarball {
      sha256 = "1qmq5zwd4qdxdxh4zxc7yr7qwajgnsjdw2npw0rfkyahmrqw3j02";
      url =
        "https://github.com/msteen/nixos-vsliveshare/archive/86624fe317c24df90e9451dd5741220c98d2249d.tar.gz";
    })
  ];

  services.vsliveshare = {
    enable = true;
    enableWritableWorkaround = true;
    enableDiagnosticsWorkaround = true;
    extensionsDir = "/home/matthijs/.vscode/extensions";
  };
}
