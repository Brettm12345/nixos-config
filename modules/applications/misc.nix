{ config, lib, pkgs, ... }:
with import ../../support.nix { inherit lib config pkgs; }; {
  systemd.coredump.enable = true;
  environment.sessionVariables.NIX_AUTO_RUN = "1";
  services.atd.enable = true;
  home-manager.users.brett = {
    home = {
      activation."mimeapps-remove" =
        afterLinkGen "rm -f /home/brett/.config/mimeapps.list";
      activation."user-dirs-remove" =
        afterLinkGen "rm -f /home/brett/.config/user-dirs.dirs";
      packages = with pkgs; [
        buku
        chromium
        clang
        clang-tools
        bibata-cursors
        catimg
        curl
        dfc
        entr
        dmenu
        gnome3.dconf
        fd
        feh
        flameshot
        gksu
        httpie
        htop
        jq
        nix-du
        nix-index
        ffmpeg-full
        haskellPackages.greenclip
        gitAndTools.hub
        mediainfo
        gnupg
        gopass
        grc
        libnotify
        lldb
        ripgrep
        platinum-searcher
        silver-searcher
        slack
        ranger
        stdman
        vscode
        yank
        unrar
        wget
        xdg_utils
        zip
      ];
    };

    # services.gpg-agent = {
    #   enable = true;
    #   defaultCacheTtl = 1800;
    #   enableSshSupport = true;
    # };

    programs.command-not-found.enable = true;
    systemd.user.startServices = true;
  };
}
