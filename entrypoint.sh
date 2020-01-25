#!/usr/bin/env sh
set -euo pipefail

# Write out our signing key to disk
MINISIGN_KEY_PATH="${MINISIGN_KEY_PATH:-"$HOME/.minisign/minisign.key"}"
[[ ! -z "${INPUT_MINISIGN_KEY:-}" ]] \
    && mkdir -p "$(dirname $MINISIGN_KEY_PATH)"\
    && printenv INPUT_MINISIGN_KEY > "${MINISIGN_KEY_PATH}"

# This seems to be the best way to workaround the password prompt
# (https://github.com/jedisct1/minisign/issues/43) and because minisign fails if
# it can't read from stdin.
#
# We also need to turn off pipefail here because otherwise when minisign closes
# the echo in the while loop will start failing causing the whole program to
# fail.
set +o pipefail
(while true; do echo "${INPUT_PASSWORD:-}"; done) | (set -x; /minisign $@)