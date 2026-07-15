{
  pkgs,
  config,
  nix-gl-host,
  ...
}:
{
  home = {
    packages = with pkgs; [
      home-manager
      nixfmt
      tig
    ];

    username = "user";
    homeDirectory = "/home/user";

    stateVersion = "26.05";

    sessionVariables = {
      LESS = "-SFXR --mouse";
    };
  };

  programs = {
    git = {
      enable = true;
    };

    difftastic = {
      enable = true;
      git = {
        enable = true;
      };
    };

    bash = {
      enable = true;
      bashrcExtra = ''
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      '';
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    ghostty = {
      enable = true;
      package = pkgs.writeShellScriptBin "ghostty" ''
        exec ${nix-gl-host.packages.${pkgs.system}.default}/bin/nixglhost ${pkgs.ghostty}/bin/ghostty "$@"
      '';
      settings = {
        theme = "GitHub Dark High Contrast";

        custom-shader = "${./resources/cursor_blaze.glsl}";
        cursor-color = "#ffffff";
        cursor-text = "#000000";
        cursor-style = "block";
        shell-integration-features = "no-cursor";
      };
    };
  };

  xdg = {
    enable = true;
    desktopEntries.ghostty = {
      type = "Application";
      name = "Ghostty";
      icon = "${pkgs.ghostty}/share/icons/hicolor/256x256/apps/com.mitchellh.ghostty.png";
      exec = "${config.programs.ghostty.package}/bin/ghostty";
    };
  };
}
