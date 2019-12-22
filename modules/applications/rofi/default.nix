{ config, ... }: {
  home-manager.users.brett.programs.rofi = {
    enable = true;
    cycle = true;
    font = "Proxima Nova Medium 18";
    fullscreen = false;
    padding = 10;
    theme = ./Moonlight.rasi;
    width = 2000;
    extraConfig = ''
      rofi.icon-theme: Papirus
      rofi.lines: 10
      rofi.location: 0
      rofi.combi-modi: window,drun,run
      rofi.modi: combi
      rofi.padding: 10
      rofi.display-window:  
      rofi.display-windowcd:  
      rofi.display-run:  
      rofi.display-ssh:  
      rofi.display-drun:  
      rofi.display-combi:  
      rofi.run-command: fish -c '{cmd}'
      rofi.run-list-command: 'fish -c functions'
      rofi.separator-style: none
      rofi.show-icons: true
      rofi.threads: 8

      rofi.kb-accept-entry: Return
      rofi.kb-remove-char-back: BackSpace
      rofi.kb-remove-to-eol: Alt+k
      rofi.kb-screenshot: Alt+s
    '';
  };
}
