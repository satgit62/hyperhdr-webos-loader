#!/bin/bash

LOCKFILE="/tmp/lut_script.lock"

LUT_URL="https://github.com/satgit62/satgit62.github.io/releases/download/v0.2.0-alpha/lut_uncompressed.tar.gz"

HYPERHDR_PATH="/media/developer/apps/usr/palm/services/org.webosbrew.hyperhdr.loader.service/hyperhdr"
ROOT_HYPERHDR_PATH="/home/root/.hyperhdr"
TMP_DIR="/tmp"
REQUIRED_SPACE_MB=460
LUT_FILENAME="lut_uncompressed.tar.gz"


check_space() {
    local available_space=$(df "$HYPERHDR_PATH" | awk 'NR==2 {print $4}')
    available_space=$((available_space / 1024))

    if (( available_space < REQUIRED_SPACE_MB )); then
        luna-send -a webosbrew -f -n 1 luna://com.webos.notification/createToast '{"sourceId":"webosbrew","message": "<b>No enough place available to install uncompressed LUT!!!</b>"}'
        exit 1
    fi
}

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
        exit 1
    }

    rm -f "$lut_file"
}


create_symlinks() {
    ln -sf "$HYPERHDR_PATH/lut_lin_tables.3d" "$ROOT_HYPERHDR_PATH/lut_lin_tables_sdr.3d"
    ln -sf "$HYPERHDR_PATH/lut_lin_tables_hdr.3d" "$ROOT_HYPERHDR_PATH/lut_lin_tables_hdr.3d"
    ln -sf "$HYPERHDR_PATH/lut_lin_tables_dv.3d" "$ROOT_HYPERHDR_PATH/lut_lin_tables_dv.3d"
}

send_notification() {
    luna-send -a webosbrew -f -n 1 luna://com.webos.notification/createToast '{"sourceId":"webosbrew","message": "<b>Uncompressed Lut Installed!</b>"}'
}


if [[ -f "$LOCKFILE" ]]; then
exit 1
fi

touch "$LOCKFILE"

trap 'rm -f "$LOCKFILE"; exit' EXIT

clean_up
check_space

download_and_decompress
create_symlinks
send_notification

rm -f "$LOCKFILE"
