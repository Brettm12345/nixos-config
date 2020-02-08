{ pkgs, config, lib, ... }:
with import ../../support.nix { inherit lib config pkgs; }; {
  environment.systemPackages = with pkgs; [ starship ];
  home-manager.users.brett = {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      settings = with lib;
        with builtins;
        let
          fromKey = key:
            mapAttrs' (name: value: nameValuePair name { "${key}" = value; });
          symbols = fromKey "symbol";
          style = fromKey "style";
          disable = x:
            listToAttrs (map (name: nameValuePair name { disabled = true; }) x);
        in (symbols {
          aws = " ";
          conda = " ";
          git_branch = " ";
          golang = " ";
          package = " ";
          rust = " ";
        } // style {
          directory = "blue";
          haskell = "purple";
        } // disable [ "battery" ] // {
          character.style_success = "purple";
          git_status = {
            prefix = "";
            suffix = " ";
            style = "yellow";
          };
          nix_shell.use_name = true;
        });
    };
  };
}
