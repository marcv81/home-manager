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

  programs = {
    bash = {
      enable = true;
      bashrcExtra = ''
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      '';
    };
  };
}
