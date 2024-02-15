#!/usr/bin/env bash

# Install Xcode
XCODE_VERSION="15.2"
XCODE_DOWNLOAD_URL="https://developer.apple.com/services-account/download?path=/Developer_Tools/Xcode_$XCODE_VERSION/Xcode_$XCODE_VERSION.xip"
XCODE_BUILD=/usr/bin/xcodebuild

open_xcode_download() {
    read "click any keyboard key to open the download URL"
    open $XCODE_DOWNLOAD_URL
    read "Download the file and move to /Applications."
    # exit 1
}

if [[ -f "$XCODE_BUILD" ]]; then
    INSTALLED_VERSION=$(eval "${XCODE_BUILD} -version | head -l | sed 's/[[:alpha:]|(|[:space:]]//g' | awk -F- '{print $1}'")
    if [ "INSTALLED_VERSION" = "$XCODE_VERSION" ]; then
        echo "Xcode Installed"
    else
        echo "Wrong Xcode version!"
        open_xcode_download
    fi
else
    echo "Xcode not found"
    open_xcode_download
fi

xcode-select --install