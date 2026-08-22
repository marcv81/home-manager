{
  pkgs,
  config,
  nix-gl-host,
  helix-fork,
  ...
}:
{
  home = {
    packages = with pkgs; [
      home-manager
      nixfmt
      tig
      ripgrep
    ];

    username = "user";
    homeDirectory = "/home/user";

    stateVersion = "26.05";

    sessionVariables = {
      LESS = "-SFXR --mouse";

      OPENCODE_ENABLE_TELEMETRY = "1";
      OPENCODE_OTLP_ENDPOINT = "http://localhost:4317";
    };

    # Mirror system theme.
    pointerCursor = {
      package = pkgs.yaru-theme;
      name = "Yaru";
      size = 64;
      gtk.enable = true;
    };
  };


  home.file.".tigrc".source = ./resources/tigrc;

  programs = {
    fzf = {
      enable = true;
    };

    git = {
      enable = true;
    };

    helix = {
      enable = true;
      package = helix-fork.packages.${pkgs.stdenv.hostPlatform.system}.helix;
      defaultEditor = true;
      settings.theme = "github_dark_high_contrast";
      settings.editor.cursor-shape = {
        normal = "terminal-block";
        insert = "terminal-block";
        select = "terminal-block";
      };
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

    opencode = {
      enable = true;
      settings = {
        plugin = [ "@devtheops/opencode-plugin-otel" ];
      };
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

          cursor-text = "cell-background";
          cursor-color = "cell-foreground";
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
