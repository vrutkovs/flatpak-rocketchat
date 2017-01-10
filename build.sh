#!/bin/sh

set -eux

rm -rf app
flatpak-builder --ccache --require-changes --repo=repo --subject="Nightly build of Rocket.Chat, `date`" app chat.rocket.App.json

flatpak build-update-repo --prune --prune-depth=20 repo

# The following commands should be performed once
flatpak --user remote-add --no-gpg-verify nightly-rocketchat ./repo || true
flatpak --user -v install nightly-rocketchat chat.rocket.App || true

flatpak update --user chat.rocket.App
