{ pkgs, config, lib, ... }:
with lib;
with types;
let secrets = import ../secret.nix;
in rec {
  options.secrets = {
    aws = submodule {
      access-key = mkOption {
        type = nullOr str;
        description = "Aws access key";
      };
      secret = mkOption {
        type = nullOr str;
        description = "Aws secret key";
      };

    };
    passwordHash = mkOption {
      type = str;
      description = "The root password hash";
    };
    github = submodule {
      personal-access-token = mkOption {
        type = nullOr str;
        description = "Github access token";
      };
    };
    id_rsa = mkOption {
      type = nullOr str;
      description = "SSH RSA private key";
    };
  };
  config.secrets = secrets;
}
