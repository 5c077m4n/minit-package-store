#!/usr/bin/env bash

workdir="${MINIT_BUILD_WORKDIR:-"/app/build"}"
version="${MINIT_BUILD_VERSION:-"v0.10.3"}"
arch="${MINIT_BUILD_ARCH:-"$(arch)"}"
os="${MINIT_BUILD_OS:-"macos"}"

echo "$workdir"
echo "$version"
echo "$arch"
echo "$os"

mkdir -p "$workdir"
cd "$workdir" || exit 1

apt update && apt install --yes curl

file_name="nvim-${os}-${arch}.tar.gz"
file_url="https://github.com/neovim/neovim/releases/download/${version}/${file_name}"
curl --remote-name "$file_url"

# TODO: consider moving the sha256sums to repo
curl --remote-name "${file_url}.sha256sum"
sha256sum --check --status "${file_name}.sha256sum" || exit 1
