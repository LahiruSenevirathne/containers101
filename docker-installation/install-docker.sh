#!/usr/bin/env bash

set -e

install_docker_linux() {
  echo "Installing Docker on Linux using official get-docker.sh script..."
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  sudo systemctl enable docker
  sudo systemctl start docker
  rm -f get-docker.sh
  echo "Docker installed successfully on Linux"
}

install_docker_macos() {
  echo "Installing Docker on macOS..."
  if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Please install Homebrew first: https://brew.sh/"
    exit 1
  fi
  brew install --cask docker
  echo "Docker installed successfully on macOS"
  echo "Please open Docker from Applications and grant permissions manually if required."
}

if [[ "$OSTYPE" == "darwin"* ]]; then
  install_docker_macos
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  install_docker_linux
else
  echo "Unsupported OS: $OSTYPE"
  exit 1
fi
