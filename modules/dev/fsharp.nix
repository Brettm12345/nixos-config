{ pkgs, ... }: {
  home-manager.users.brett.home.packages = with pkgs; [ dotnet-sdk mono ];
}
