#!/usr/bin/env bash

set -e
set -o pipefail

function install_stein () {
    [ -x /usr/local/bin/stein ] && {
        >&2 echo "Skipped: stein has already installed."
        return
    }
    >&2 echo "Installing: stein ..."

    STEIN_RELEASE=https://github.com/b4b4r07/stein/releases/download/v0.3.4/stein_linux_x86_64.tar.gz
    wget "$STEIN_RELEASE"
    tar zxvf stein_linux_x86_64.tar.gz
    sudo mv stein /usr/local/bin
}

main () {
    install_stein
}

main