{ pkgs, ... }: {
  home-manager.users.brett = {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs;
    };

    home.packages = [
      (pkgs.makeDesktopItem {
        terminal = "False";
        type = "Application";
        name = "emacsclient";
        genericName = "Text editor";
        desktopName = "Emacs client";
        mimeType = "text/plain";
        exec = "emacsclient -c %F";
        categories = "Development;TextEditor;";
        icon = "emacs";
      })
      pkgs.clang
    ];

    services.emacs.enable = true;

    systemd.user.services.emacs.Service.Environment =
      "PATH=/run/current-system/sw/bin:/etc/profiles/per-user/brett/bin";

    home.file.".emacs.d/init.el".source = ./init.el;
    home.file.".emacs.d/elisp/gud-lldb.el".source = ./gud-lldb.el;
    home.activation.emacs = {
      before = [ ];
      after = [ ];
      data = "$DRY_RUN_CMD mkdir -p ~/.emacs.d/autosave";
    };
  };
}
