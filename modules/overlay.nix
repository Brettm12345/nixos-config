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
        # nixfmt = callPackage imports.nixfmt { };
        doom-emacs = callPackage imports.nix-doom-emacs {
          doomPrivateDir = "${xdg.configHome}/doom";
        };
        xmonad-config = callPackage imports.xmonad-config { };
        bs-platform = callPackage imports.bs-platform { };
        vscode = unstable.vscode;
        # zinit = mkDerivation rec {
        #   name = "zinit";
        #   src = imports.zinit;
        # };
        compton-rounded-corners = super.compton.overrideAttrs (_: {
          name = "compton-rounded-corners";
          version = "next";
          src = imports.compton;
        });
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
        slack = super.slack.override { theme = super.slack-theme-black; };
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
      "https://brettm12345.cachix.org"
      "https://all-hies.cachix.org"
    ];
    binaryCachePublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "all-hies.cachix.org-1:JjrzAOEUsD9ZMt8fdFbzo3jNAyEWlPAwdVuHw4RD43k="
    ];
  };
}
