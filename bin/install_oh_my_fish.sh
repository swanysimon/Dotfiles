#!/usr/bin/env bash

set -euxo pipefail

if command -v omf; then
    omf update
    exit 0
fi

OMF_INSTALLER="$(mktemp -d)/install"
OMF_INSTALLER_URL="$(curl -fsL -o "$OMF_INSTALLER" -w %{url_effective} "https://get.oh-my.fish")"

curl -fs "${OMF_INSTALLER_URL}.sha256" | sha256sum --check

fish install

rm -rf "$(dirname "$OMF_INSTALLER")"
