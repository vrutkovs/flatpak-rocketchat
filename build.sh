#!/bin/sh

set -eux

rm -rf app

pushd electron-flatpak-base-app
    make
    flatpak build-update-repo --prune --prune-depth=20 ./repo
    flatpak --user remote-add --no-gpg-verify local-electron ./repo || true
    flatpak --user -v install local-electron io.atom.electron.BaseApp || true
    flatpak update --user io.atom.electron.BaseApp
popd

flatpak-builder --ccache --require-changes --repo=repo --subject="Nightly build of Rocket.Chat, `date`" app chat.rocket.App.json

flatpak build-update-repo --prune --prune-depth=20 repo

# The following commands should be performed once
flatpak --user remote-add --no-gpg-verify nightly-rocketchat ./repo || true
flatpak --user -v install nightly-rocketchat chat.rocket.App || true

flatpak update --user chat.rocket.App
