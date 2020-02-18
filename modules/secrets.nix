{ lib, ... }:
with lib;
with types;
let
  secret = description:
    mkOption {
      inherit description;
      type = nullOr str;
    };
in {

  options.secrets = {
    aws = submodule {
      access-key = secret "Aws access key";
      secret = secret "Aws secret key";
    };
    github = submodule { personal-access-token = secret "Github acces token"; };
    passwordHash = secret "The root password hash";
    id_rsa = secret "Ssh rsa private key";
  };
  config.secrets = import ../secret.nix;
}
