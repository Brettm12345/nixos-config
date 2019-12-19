let
  imports = import ../nix/sources.nix;
  new = import imports.nixpkgs-unstable { config.allowUnfree = true; };
in { lib, ... }:
with builtins; {
  nixpkgs.overlays = [
    (self: super: rec {
      inherit imports;
      unstable = new;
      nixfmt = self.callPackage imports.nixfmt { };
      bs-platform = self.callPackage imports.bs-platform { };
      inherit (import imports.niv { }) niv;
      neovim = unstable.neovim;
      dmenu = super.dmenu.override {
        patches = map fetchurl [
          {
            url =
              "https://tools.suckless.org/dmenu/patches/line-height/dmenu-lineheight-4.9.diff";
            sha256 = "0v609mmz3i5dlfdf4b8wcp48njxp1i5g5vy7phw3zg1wn936yzsg";
          }
          {
            url =
              "https://tools.suckless.org/dmenu/patches/numbers/dmenu-numbers-4.9.diff";
            sha256 =
              "f79de21544b83fa1e86f0aed5e849b1922ebae8d822e492fbc9066c0f07ddb69";
          }
          {
            url =
              "https://tools.suckless.org/dmenu/patches/fuzzymatch/dmenu-fuzzymatch-4.9.diff";
            sha256 = "0yababzi655mhpgixzgbca2hjckj16ykzj626zy4i0sirmcyg8fr";
          }
        ];
      };
      chromium = super.chromium.override {
        commandLineArgs = "--force-dark-mode --force-device-scale-factor=1.2";
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
  environment.etc.nixpkgs.source = imports.nixpkgs;
  nix = rec {
    nixPath = lib.mkForce [
      "nixpkgs=/etc/nixpkgs"
      "nixos-config=/etc/nixos/configuration.nix"
    ];
    trustedUsers = [ "root" "brett" "@wheel" ];
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
