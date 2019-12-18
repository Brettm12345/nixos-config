{ ... }:
let home = "/home/brett";
in {
  home-manager.users.brett.xdg = {
    enable = true;
    configHome = "${home}/.config";
    cacheHome = "${home}/var/cache";
    dataHome = "${home}/usr/share";
    userDirs = {
      enable = true;
      desktop = "${home}/usr/dsk";
      documents = "${home}/usr/doc";
      download = "${home}/usr/dwl";
      music = "${home}/usr/msc";
      pictures = "${home}/usr/img";
      templates = "${home}/usr/tmp";
      videos = "${home}/usr/vid";
    };
  };
}
