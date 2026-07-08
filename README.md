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
