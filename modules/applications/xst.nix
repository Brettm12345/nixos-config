{ pkgs, ... }: {
  home-manager.users.brett = {
    xresources.properties = {
      "st.shell" = "${pkgs.fish}/bin/fish";
      "st.cursorshape" = 5;
      "st.xfps" = 1000;
      "st.actionfps" = 1000;
      "st.font" = "Roboto Mono:pixelsize=14:antialias=true:autohint=true;";
      "st.borderpx" = 0;
    };
  };
}
