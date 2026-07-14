{ pkgs, ... } :
{
  home = {
    packages = with pkgs; [
      home-manager
    ];

    username = "user";
    homeDirectory = "/home/user";

    stateVersion = "26.05";
  };
}
