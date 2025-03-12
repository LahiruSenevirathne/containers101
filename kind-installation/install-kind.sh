#!/usr/bin/env bash

set -eux

install_kind_linux() {
  # For AMD64 / x86_64
  [ "$(uname -m)" = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.27.0/kind-linux-amd64
  # For ARM64
  [ "$(uname -m)" = aarch64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.27.0/kind-linux-arm64
  chmod +x ./kind
  sudo mv ./kind /usr/local/bin/kind

}

install_kind_macos() {
  # For Intel Macs
  [ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.27.0/kind-darwin-amd64
  # For M1 / ARM Macs
  [ $(uname -m) = arm64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.27.0/kind-darwin-arm64
  chmod +x ./kind
  sudo mv ./kind /usr/local/bin/kind

}
echo -e "Installing KIND...\n"
[[ "$OSTYPE" == "darwin"* ]] && install_kind_macos
[[ "$OSTYPE" == "linux-gnu" ]] && install_kind_linux

echo -e "Installing KIND Clodu Provider...\n"

go install sigs.k8s.io/cloud-provider-kind@latest
sudo install ~/go/bin/cloud-provider-kind /usr/local/bin

echo -e "To Expose application via LoadBalancer in KIND;\n Run 'sudo cloud-provider-kind' in a seperate terminal session"
