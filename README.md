# Intro

This is how I use Home Manager. I followed https://github.com/evertras/simple-homemanager.

Do **not** install Nix through `apt`. It does not work, and it does not uninstall cleanly.

# Nix

Follow the official instructions at https://nix.dev/install-nix.

    curl -L https://nixos.org/nix/install | sh -s -- --daemon

Create `~/.config/nix/nix.conf` with the following contents.

    experimental-features = nix-command flakes

# Home Manager

If Home Manager is not installed, we can run it in a Nix shell.

    nix shell nixpkgs#home-manager

Then we can install the flake, which subsequently provides Home Manager.

    home-manager switch --flake .#user

# Environment variables

This is how I observe Home Manager handles environment variables. I don't actually follow the logic.

## `~/.bashrc`

- Entry point for non-login shells
- Sources `hm-session-vars.sh` (through a `bashrcExtra` hack, I don't understand why this is not the default)

## `~/.bash_profile`

- Entry point for login shells
- Sources `~/.profile`
  - Sources `hm-session-vars.sh`
  - Contains environment variables controlled by `programs.bash.sessionVariables` (I don't understand why, it will expose the variables to other processes than bash)
- Then sources `~/.bashrc`

## `hm-session-vars.sh`

- Contains environment variables controlled by `home.sessionVariables`
- Contains implicitly defined environment variables, for instance from `programs`.
