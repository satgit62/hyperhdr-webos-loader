#!/bin/bash


LOCKFILE="/tmp/lut_script.lock"

LUT_URL="https://github.com/satgit62/satgit62.github.io/releases/download/v0.2.0-alpha/lut_default.tar.gz"

HYPERHDR_PATH="/media/developer/apps/usr/palm/services/org.webosbrew.hyperhdr.loader.service/hyperhdr"
ROOT_HYPERHDR_PATH="/home/root/.hyperhdr"
TMP_DIR="/tmp"
LUT_FILENAME="lut_default.tar.gz"


clean_up() {
    
    rm -f "$HYPERHDR_PATH"/*.3d
    rm -f "$HYPERHDR_PATH"/*.zst
    rm -f "$ROOT_HYPERHDR_PATH"/*.3d
    rm -f "$ROOT_HYPERHDR_PATH"/*.zst
    rm -f "$TMP_DIR/lut*.tar.gz"

}

download_and_decompress() {
    local lut_file="$TMP_DIR/$LUT_FILENAME"
    curl -L -o "$lut_file" "$LUT_URL" || {
        exit 1
    }

    tar xvzf "$lut_file" -C "$HYPERHDR_PATH" || {
        rm -f "$lut_file"
        exit 1
    }

    rm -f "$lut_file"
}

send_notification() {
    luna-send -a webosbrew -f -n 1 luna://com.webos.notification/createToast '{"sourceId":"webosbrew","message": "<b>Default Lut installed!</b>"}'
}

if [[ -f "$LOCKFILE" ]]; then
    exit 1
fi

touch "$LOCKFILE"

trap 'rm -f "$LOCKFILE"; exit' EXIT

clean_up
download_and_decompress
send_notification

rm -f "$LOCKFILE"
