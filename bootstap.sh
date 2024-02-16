#!/usr/bin/env bash
echo "\n\n************************************"
echo "*   🧑‍💻 ANetto.dev MacOS Setup 🛠️    *" 
echo "************************************"

# Ask for the administrator password upfront
echo "🔑 Need the administrator password upfront." 
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

### Install Xcode
# XCODE_VERSION="15.2"
# XCODE_DOWNLOAD_URL="https://developer.apple.com/services-account/download?path=/Developer_Tools/Xcode_$XCODE_VERSION/Xcode_$XCODE_VERSION.xip"
# XCODE_BUILD=/usr/bin/xcodebuild

# open_xcode_download() {
#     read "press any key..."
#     open $XCODE_DOWNLOAD_URL
#     read "🛠️ Download the file and move to /Applications."
#     # exit 1
# }

# if [[ -f "$XCODE_BUILD" ]]; then
#     INSTALLED_VERSION=$(eval "${XCODE_BUILD} -version | head -l | sed 's/[[:alpha:]|(|[:space:]]//g' | awk -F- '{print $1}'")
#     if [ "INSTALLED_VERSION" = "$XCODE_VERSION" ]; then
#         echo "✅ Xcode already Installed!"
#     else
#         echo "❌ Wrong Xcode version! Download now!"
#         open_xcode_download
#     fi
# else
#     echo "❌ Xcode not found! Download now!"
#     open_xcode_download
# fi

xcode-select --install

### Oh My ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

### Removing previous dotfiles in ~/
# rm -rf -- ~/.[!.]*

### ZSH plugins
rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions #~/.zsh/zsh-autosuggestions
#source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

### powerlevel10k
rm -rf ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

#source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
#echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc
#p10k configure

### creating symbolic links
rm -rf ~/.gitconfig
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

rm -rf ~/.zshrc
ln -s ~/.dotfiles/.zshrc ~/.zshrc

# exec zsh
zsh
source ~/.zshrc