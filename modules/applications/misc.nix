{ config, lib, pkgs, ... }:
with import ../../support.nix { inherit lib config pkgs; }; {
  systemd.coredump.enable = true;
  environment.sessionVariables = with config.defaultApplications.editor; {
    EDITOR = cmd;
    VISUAL = cmd;
    NIX_AUTO_RUN = "1";
  };
  services.atd.enable = true;
  home-manager.users.brett = {
    home = {
      activation."mimeapps-remove" =
        afterLinkGen "rm -f /home/brett/.config/mimeapps.list";
      packages = with pkgs; [
        bibata-cursors
        chromium
        clang
        clang-tools
        curl
        dunst
        dmenu
        gnome3.dconf
        ffmpeg-full
        neovim
        gitAndTools.hub
        gnupg
        gopass
        grc
        libnotify
        lldb
        ranger
        stdman
        vscode
        unrar
        wget
        xdg_utils
        zip
      ];
    };

    services.gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };

    programs.command-not-found.enable = true;
    systemd.user.startServices = true;
  };
}
