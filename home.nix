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
      ripgrep
    ];

    username = "user";
    homeDirectory = "/home/user";

    stateVersion = "26.05";

    sessionVariables = {
      LESS = "-SFXR --mouse";
    };

    # Mirror system theme.
    pointerCursor = {
      package = pkgs.yaru-theme;
      name = "Yaru";
      size = 64;
      gtk.enable = true;
    };
  };

  programs = {
    fzf = {
      enable = true;
    };

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
      shellAliases = {
        "ls" = "ls --color=auto";
      };
      bashrcExtra = ''
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      '';
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    starship = {
      enable = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        neo-tree-nvim
        gitsigns-nvim
        github-nvim-theme
      ];
      initLua = builtins.concatStringsSep "\n" (map builtins.readFile [
        ./resources/init.lua
        ./resources/gitsigns.lua
        ./resources/mouse.lua
      ]);
    };

    ghostty =
      let
        nixglhostPath = "${nix-gl-host.packages.${pkgs.stdenv.hostPlatform.system}.default}";
      in
      {
        enable = true;
        package = pkgs.writeShellScriptBin "ghostty" ''
          exec ${nixglhostPath}/bin/nixglhost ${pkgs.ghostty}/bin/ghostty "$@"
        '';
        settings = {
          theme = "GitHub Dark High Contrast";

          custom-shader = "${./resources/cursor_blaze.glsl}";
          custom-shader-animation = "always";

          cursor-color = "#ffffff";
          cursor-text = "#000000";
          cursor-style = "block";
          shell-integration-features = "no-cursor";

          async-backend = "epoll";
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
