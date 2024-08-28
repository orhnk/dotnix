#!/bin/sh

options="--log-format internal-json --option accept-flake-config true"

if [[ $1 == "-h" || $1 == "--help" ]]; then
    echo "Usage: $0 [-h | --help] [options] [machine-name]"
    exit
fi

# Initialize an empty string to collect additional arguments
rebuild_options=""

# Check if the first argument is an option or machine name, and shift if it's not help
if [[ $# -gt 1 ]]; then
    # Skip the first argument for nixos-rebuild switch
    shift
    rebuild_options="$@"
fi

machine=$1

if [[ -z $machine ]]; then
    available_machines=$(ls --format=commas machines)
    read -p "What machine would you like to build? (Possible options: $available_machines): " machine
fi

sudo true
# Now, only pass the collected additional arguments to nixos-rebuild switch
nix-shell --packages git --command "sudo nixos-rebuild switch $rebuild_options $options --flake .#$machine |& nom --json"

# Specify the directory path
DOOM_CONFIG_DIR="./modules/emacs"

if [[ ! -d ~/.config/emacs/ ]]; then
  git clone https://github.com/doomemacs/doomemacs ~/.config/emacs/
else
  echo "Detected Emacs Config on ~/.config/emacs"
fi

# Check for changes including staged and unstaged changes, new, deleted, and renamed files
if git diff --exit-code --quiet $DOOM_CONFIG_DIR && git diff --cached --exit-code --quiet $DOOM_CONFIG_DIR; then
  echo "No changes in $DOOM_CONFIG_DIR"
else
  echo "Changes detected in $DOOM_CONFIG_DIR"
  ~/.config/emacs/bin/doom sync
fi
