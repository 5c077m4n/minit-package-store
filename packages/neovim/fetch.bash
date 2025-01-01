#!/usr/bin/env bash

workdir="${MINIT_BUILD_WORKDIR:-"/tmp/build"}"
version="${MINIT_BUILD_VERSION:-"v0.10.3"}"
arch="${MINIT_BUILD_ARCH:-"$(arch)"}"
os="${MINIT_BUILD_OS:-"macos"}"

mkdir -p "$workdir"
cd "$workdir" || exit 1

file_name="nvim-${os}-${arch}.tar.gz"
curl --remote-name "https://github.com/neovim/neovim/releases/download/${version}/${file_name}"

# TODO: consider moving the sha256sums to repo
curl --remote-name "https://github.com/neovim/neovim/releases/download/${version}/${file_name}.sha256sum"
sha256sum --check --status "${file_name}.sha256sum" || exit 1
