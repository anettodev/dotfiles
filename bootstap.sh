#!/usr/bin/env bash

### Install Xcode
XCODE_VERSION="15.2"
XCODE_DOWNLOAD_URL="https://developer.apple.com/services-account/download?path=/Developer_Tools/Xcode_$XCODE_VERSION/Xcode_$XCODE_VERSION.xip"
XCODE_BUILD=/usr/bin/xcodebuild

open_xcode_download() {
    open $XCODE_DOWNLOAD_URL
    read "🛠️ Download the file and move to /Applications."
    # exit 1
}

if [[ -f "$XCODE_BUILD" ]]; then
    INSTALLED_VERSION=$(eval "${XCODE_BUILD} -version | head -l | sed 's/[[:alpha:]|(|[:space:]]//g' | awk -F- '{print $1}'")
    if [ "INSTALLED_VERSION" = "$XCODE_VERSION" ]; then
        echo "✅ Xcode already Installed!"
    else
        echo "❌ Wrong Xcode version! Download now!"
        open_xcode_download
    fi
else
    echo "❌ Xcode not found! Download now!"
    open_xcode_download
fi

xcode-select --install

### Oh My ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
rm -rf ~/.zshrc
brew install zsh-syntax-highlighting

### Removing previous dotfiles in ~/
# rm -rf -- ~/.[!.]*

### creating symbolic links
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.zshrc ~/.zshrc

source ~/.dotfiles/.zshrc

### powerlevel10k
brew install powerlevel10k
echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc

p10k configure
