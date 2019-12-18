{ pkgs, config, lib, ... }:
with import ../support.nix { inherit lib config pkgs; }; {
  options.defaultApplications = lib.mkOption {
    type = lib.types.attrs;
    description = "Preferred applications";
  };
  config = rec {
    defaultApplications = {
      term = {
        cmd = "${pkgs.termite}/bin/termite";
        desktop = "termite";
      };
      editor = {
        cmd = "${pkgs.neovim}/bin/nvim";
        desktop = "code";
      };
      browser = {
        cmd = "${pkgs.chromium}/bin/chromium";
        desktop = "chromium";
      };
      fm = {
        cmd = "${pkgs.dolphin}/bin/dolphin";
        desktop = "dolphin";
      };
      monitor = {
        cmd = "${pkgs.ksysguard}/bin/ksysguard";
        desktop = "ksysguard";
      };
      archive = {
        cmd = "${pkgs.ark}/bin/ark";
        desktop = "org.kde.ark";
      };
      text_processor = {
        cmd = "${pkgs.abiword}/bin/abiword";
        desktop = "abiword";
      };
      spreadsheet = {
        cmd = "${pkgs.gnumeric}/bin/gnumeric";
        desktop = "gnumeric";
      };
    };
    home-manager.users.brett.xdg.configFile."mimeapps.list.home".text =
      with config.defaultApplications;
      let
        apps = builtins.mapAttrs (_: value: "${value.desktop}.desktop;") {
          "text/html" = browser;
          "image/*" = { desktop = "org.kde.gwenview"; };
          "application/zip" = archive;
          "application/rar" = archive;
          "application/7z" = archive;
          "application/*tar" = archive;
          "application/x-kdenlive" = archive;
          "x-scheme-handler/http" = browser;
          "x-scheme-handler/https" = browser;
          "x-scheme-handler/about" = browser;
          "x-scheme-handler/unknown" = browser;
          "application/pdf" = { desktop = "org.kde.okular"; };
          "application/vnd.openxmlformats-officedocument.wordprocessingml.document" =
            text_processor;
          "application/msword" = text_processor;
          "application/vnd.oasis.opendocument.text" = text_processor;
          "text/csv" = spreadsheet;
          "application/vnd.oasis.opendocument.spreadsheet" = spreadsheet;
          "text/plain" =
            editor; # This actually makes Emacs an editor for everything... XDG is wierd
        };
      in genIni {
        "Default Applications" = apps;
        "Added Associations" = apps;
      };
    home-manager.users.brett.xdg.configFile."filetypesrc".text = genIni {
      EmbedSettings = {
        "embed-application/*" = false;
        "embed-text/*" = false;
        "embed-text/plain" = false;
      };
    };
    home-manager.users.brett.home.activation.mimeapps = {
      before = [ ];
      after = [ "linkGeneration" ];
      data =
        "$DRY_RUN_CMD cp ~/.config/mimeapps.list.home ~/.config/mimeapps.list";
    };
  };
}
