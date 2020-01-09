{ pkgs, config, lib, ... }:
with import ../../support.nix { inherit lib config pkgs; }; {
  environment.systemPackages = with pkgs; [ starship ];
  home-manager.users.brett = {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
    xdg.configFile."starship.toml".text = with lib;
      with builtins;
      let
        symbols =
          mapAttrs' (name: symbol: nameValuePair name { inherit symbol; });
        disable = x:
          listToAttrs (map (name: nameValuePair name { disabled = true; }) x);
      in genToml (symbols {
        aws = " ";
        conda = " ";
        git_branch = " ";
        golang = " ";
        package = " ";
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
}
