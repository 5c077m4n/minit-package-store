#!/usr/bin/env bash

set -euxo pipefail

workdir="${MINIT_BUILD_WORKDIR:-"/app/build"}"
outdir="${MINIT_BUILD_OUTDIR:-"/app/final"}"
version="${MINIT_BUILD_VERSION:-"v0.10.3"}"
arch="${MINIT_BUILD_ARCH:-"arm64"}"
os="${MINIT_BUILD_OS:-"macos"}"

echo "$workdir"
echo "$outdir"
echo "$version"
echo "$arch"
echo "$os"

mkdir -p "$workdir"
mkdir -p "$outdir"
cd "$workdir"

apt update && apt install --yes curl

file_name="nvim-${os}-${arch}.tar.gz"
file_url="https://github.com/neovim/neovim/releases/download/${version}/${file_name}"
curl --remote-name --location "$file_url"
stat "$file_name"

# TODO: consider moving the sha256sums to repo
curl --remote-name --location "${file_url}.sha256sum"
stat "${file_name}.sha256sum"
cat "${file_name}.sha256sum"

sha256sum --check --status "${file_name}.sha256sum"

mv "./${file_name}" "${outdir}/${file_name}"
