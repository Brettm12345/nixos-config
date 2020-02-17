let
  imports = import ../nix/sources.nix;
  new = import imports.nixpkgs-unstable { config.allowUnfree = true; };
in { lib, pkgs, config, ... }:
with builtins;
with import ../support.nix { inherit lib pkgs config; }; {
  nixpkgs.overlays = [
    (self: super:
      with self;
      with self.stdenv; rec {
        inherit imports;
        unstable = new;
        nixfmt = callPackage imports.nixfmt { };
        doom-emacs = callPackage imports.nix-doom-emacs {
          doomPrivateDir = "${xdg.configHome}/doom";
        };
        xmonad = callPackage imports.xmonad-config { };
        organizr = mkDerivation {
          name = "organizr";
          src = imports.organizr;
          installPhase = ''
            mkdir -p $out/config
            cp -R . $out/
            ln -s /var/lib/organizr/config.php $out/config/config.php
          '';
        };
        bs-platform = callPackage imports.bs-platform { };
        cached-nix-shell = callPackage imports.cached-nix-shell { };
        termite = self.termite;
        snack = (import imports.snack).snack-exe;
        inherit (import imports.niv { }) niv;
        juno = mkDerivation rec {
          name = "Juno";
          src = imports.juno;
          propagatedUserEnvPkgs = [ pkgs.gtk-engine-murrine ];
          sourceRoot = ".";
          installPhase = ''
            mkdir -p $out/share/themes/Juno
            cp -a ./source/* $out/share/themes/Juno
          '';
        };

        slack-theme = mkDerivation rec {
          name = "slack-theme";
          src = imports.slack-themes;
          sourceRoot = ".";
          installPhase = ''
            mkdir -p $out
            cp $src/dist/slack.min.css $out/theme.css
          '';
        };
        slack = super.slack.override { theme = super.slack-theme-black; };

        compton =
          super.compton.overrideAttrs (old: { src = imports.compton; } // old);

        chromium = super.chromium.override {
          commandLineArgs = "--force-dark-mode --force-device-scale-factor=1.3";
        };
        all-hies = import imports.all-hies { };
      })
  ];
  nixpkgs.pkgs = import imports.nixpkgs {
    config = {
      allowUnfree = true;
      allowBroken = true;
    };
  };
  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-19.09";
  };
  environment.etc.nixpkgs.source = imports.nixpkgs;
  nix = rec {
    extraOptions = "binary-caches-parallel-connections = 5";
    nixPath = lib.mkForce [
      "nixpkgs=/etc/nixpkgs"
      "nixos-config=/etc/nixos/configuration.nix"
    ];
    trustedUsers = [ "root" "brett" "@wheel" ];
    autoOptimiseStore = true;
    gc.automatic = true;
    optimise.automatic = true;
    binaryCaches = [
      "https://cache.nixos.org"
      "https://cache.dhall-lang.org"
      "https://brettm12345.cachix.org"
      "https://all-hies.cachix.org"
    ];
    binaryCachePublicKeys = [
      "cache.dhall-lang.org:I9/H18WHd60olG5GsIjolp7CtepSgJmM2CsO813VTmM="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "all-hies.cachix.org-1:JjrzAOEUsD9ZMt8fdFbzo3jNAyEWlPAwdVuHw4RD43k="
    ];
  };
}
