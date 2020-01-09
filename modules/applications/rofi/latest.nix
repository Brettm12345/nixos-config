{ pkgs, lib, ... }: {
  home-manager.users.brett.programs.rofi = {
    enable = true;
    cycle = true;
    font = "Proxima Nova 18";
    fullscreen = false;
    padding = 10;
    lines = 10;
    location = "center";
    theme = ./Moonlight.rasi;
    width = 2000;
    extraConfig = with lib;
      concatStringsSep "\n" (attrVals (mapAttrs (n: v: "rofi.${n}: ${v}") rec {
        icon-theme = "Papirus";
        combi-modi = concatStringsSep "," [
          "window"
          "drun"
          "keys"
          "pass:${pkgs.rofi-pass}/bin/rofi-pass"
          "vscode:~/bin/rofi-vscode"
        ];
        modi = "combi,${combi-modi}";
        display-keys = "";
        display-pass = "";
        display-window = "";
        display-windowcd = "";
        display-run = "";
        display-ssh = "";
        display-drun = "";
        display-combi = "";
        run-command = "fish -c '{cmd}'";
        run-list-command = "'fish -c functions'";
        separator-style = "none";
        show-icons = true;
        threads = 8;
        kb-accept-entry = "Return";
        kb-mode-next = "Left";
        kb-mode-previous = "Right";
        kb-move-char-back = "Control+b";
        kb-move-char-forward = "Control+f";
        kb-remove-char-back = "BackSpace";
        kb-remove-to-eol = "Alt+k";
        kb-screenshot = "Alt+s";
      }));
  };
}
