#!/bin/sh

options="--log-format internal-json --option accept-flake-config true"

if [[ $1 == "-h" || $1 == "--help" ]]; then
	echo "Usage: $0 [-h | --help] [machine-name]"
	exit
fi

machine=$1

if [[ $machine == "" ]]; then
	available_machines=$(ls --format=commas machines)
	read -p "What machine would you like to build? (Possible options: $available_machines): " machine
fi

sudo echo "starting"
nix-shell --packages git --command "sudo nixos-rebuild switch $options --flake .#$machine |& nom --json"

# sudo sh -c $"nixos-rebuild switch ($flags | str join ' ') |& nom --json"

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
  # exit 0
else
  echo "Changes detected in $DOOM_CONFIG_DIR"
  ~/.config/emacs/bin/doom sync
  # exit 1
fi
