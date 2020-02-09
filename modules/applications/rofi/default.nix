{ config, pkgs, lib, ... }:
let
  rofiConfig = rec {
    combi-modi = with lib;
      concatStringsSep "," [
        "window"
        "drun"
        "run"
        "keys"
        "pass:${pkgs.rofi-pass}/bin/rofi-pass"
        "vscode:~/bin/rofi-vscode"
      ];
    modi = "combi,${combi-modi}";
    icon-theme = "Papirus";
    display-keys = "";
    display-pass = "";
    display-window = " ";
    display-windowcd = " ";
    display-run = "";
    display-ssh = " ";
    display-drun = " ";
    display-combi = " ";
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
