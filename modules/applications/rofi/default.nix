{ config, pkgs, lib, ... }:
let
  rofiConfig = rec {
    combi-modi = with lib;
      concatStringsSep "," [
        "window"
        "windowcd"
        "drun"
        "run"
        "projects:~/bin/rofi-projects"
      ];
    modi = "combi,keys,${combi-modi}";
    icon-theme = "Papirus";
    display-projects = " ";
    display-keys = "גּ ";
    display-window = " ";
    display-windowcd = " ";
    display-run = " ";
    display-ssh = " ";
    display-drun = "  ";
    display-combi = "  ";
    matching = "fuzzy";
    run-command = "fish -c '{cmd}'";
    run-list-command = "'fish -c functions'";
    separator-style = "none";
    show-icons = "true";
    threads = "8";
    kb-accept-entry = "Return";
    kb-mode-next = "Left";
    kb-mode-previous = "Right";
    kb-move-char-back = "Control+b";
    kb-move-char-forward = "Control+f";
    kb-remove-char-back = "BackSpace";
    kb-remove-to-eol = "";
    kb-screenshot = "Alt+s";
  };

in {
  home-manager.users.brett.programs.rofi = {
    enable = true;
    cycle = true;
    font = "${config.themes.fonts.monospace-alt} 16";
    fullscreen = false;
    padding = 10;
    lines = 10;
    location = "center";
    theme = ./Moonlight.rasi;
    width = 2000;
    extraConfig = with lib;
      concatStringsSep "\n"
      (attrValues (mapAttrs (n: v: "rofi.${n}: ${v}") rofiConfig));
  };
}
