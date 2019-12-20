{ config, ... }:
with builtins;
let
  home = "/home/brett";
  makeDirs = pathFn: data: mapAttrs (_: pathFn) data // { enable = true; };
  dirs = makeDirs (path: "${home}/${path}") {
    configHome = ".config";
    cacheHome = "var/cache";
    dataHome = "usr/share";
  };
  userDirs = makeDirs (path: "${home}/usr/${path}") {
    desktop = "dsk";
    documents = "doc";
    download = "dwl";
    music = "msc";
    pictures = "img";
    templates = "tmp";
    videos = "vid";
  };
in { home-manager.users.brett.xdg = dirs // { inherit userDirs; }; }
