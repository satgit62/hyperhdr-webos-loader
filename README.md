# HyperHDR for WebOS

Added option to deactivate lamps in the HA wizard

Added Zigbee2mqtt protocol

Added support for Home Assistant lights von @awawa-dev


https://github.com/awawa-dev/HyperHDR/issues/918

https://github.com/awawa-dev/HyperHDR/pull/1014

# Fix HyperHDR daemon at screensaver start 

The HyperHDR daemon is no longer stopped when the internal screensaver or the custom Aerial Screensaver for webOS is switched on. (Ambilight works When using original PicCap/hyperion-webos) 

# ai_calibration

#Fix HyperHDR daemon when starting calibration process

#Add quarter of frame mode for flatbuffers

#Grabber benchmark support for flatbuffers

#Added SDR support for libdile

#Add support for SDR (BT2020 in SRGB) calibration

#More precise color capture saving/loading

#Fix calibration for 1280x720 capturing setting

#Add NV12 image format support for flatbuffers https://github.com/awawa-dev/HyperHDR/pull/920
-------------------------------------------------------------------------------------------------------------------
Binaries are ready to install from [Homebrew Channel](https://repo.webosbrew.org/apps/org.webosbrew.hyperhdr.loader)

## Requirements

* Linux host system
* WebOS buildroot toolchain - arm-webos-linux-gnueabi_sdk-buildroot (https://github.com/openlgtv/buildroot-nc4/releases)
* git
* CMake
* npm

## Build

Build hyperhdr: `./build_hyperhdr.sh`

Build webOS frontend/service: `./build.sh`

Both scripts take an environment variable `TOOLCHAIN_DIR`, defaulting to: `$HOME/arm-webos-linux-gnueabi_sdk-buildroot`

To provide an individual path, call `export TOOLCHAIN_DIR=/your/toolchain/path` before executing respective scripts.

`build_hyperhdr.sh` also takes two other environment variables:

- `HYPERHDR_REPO`
- `HYPERHDR_BRANCH`

## References

[Hyperion.NG](https://github.com/hyperion-project/hyperion.ng)

[HyperHDR](https://github.com/awawa-dev/HyperHDR)

Video grabber of webOS: [hyperion-webos](https://github.com/webosbrew/hyperion-webos)

Frontend of Video grabber hyperion-webos: [piccap](https://github.com/TBSniller/piccap)

## Credits

@Smx-smx
@TBSniller
@Informatic
@Mariotaku
@Lord-Grey
@Paulchen-Panther
@Awawa
@chbartsch
