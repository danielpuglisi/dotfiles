#!/bin/bash

if ! command -v tinty &> /dev/null; then
  echo "tinty is not installed. Installing with Homebrew..."
  brew tap tinted-theming/tinted
  brew install tinty
fi

tinty sync

# Create required directories for output files
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/tmux

# Create the tinty config directory
mkdir -p ~/.config/tinty

echo "Tinty setup complete!"
