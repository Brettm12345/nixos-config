{ config, ... }:
let
  makeDirs = data:
    builtins.mapAttrs (_: path: "/home/brett/${path}") data // {
      enable = true;
    };
  dirs = makeDirs {
    configHome = ".config";
    cacheHome = "var/cache";
    dataHome = "usr/share";
  };
  userDirs = makeDirs {
    desktop = "usr/dsk";
    documents = "usr/doc";
    download = "usr/dwl";
    music = "usr/msc";
    pictures = "usr/img";
    templates = "usr/tmp";
    videos = "usr/vid";
  };
in { home-manager.users.brett = { xdg = dirs // { inherit userDirs; }; }; }
