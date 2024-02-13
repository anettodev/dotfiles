#!/usr/bin/env bash

echo "\n\n************************************"
echo "*   🧑‍💻 ANetto.dev MacOS Setup 🛠️    *" 
echo "************************************"

# Ask for the administrator password upfront
echo "🔑 Need the administrator password upfront." 
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# chown local directory
# sudo chown -R $(whoami):admin /usr/local

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

###############################################################################
# Screen                                                                      #
###############################################################################

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

###############################################################################
# Finder                                                                      #
###############################################################################

# Finder: show hidden files by default
defaults write com.apple.Finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Show the ~/Library folder
chflags nohidden ~/Library

###############################################################################
# Terminal                                                                    #
###############################################################################

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

###############################################################################
# Brew               
###############################################################################
# check if Brew is installed then update; else install Brew
which -s brew
if [[ $? == 0 ]] ; then
    echo "✅  brew already installed! \n\n===> Updating Brew and Upgrading any already-installed formulae .." 
    brew update
    # Upgrade any already-installed formulae.
    brew upgrade
else
    echo "❌ Brew not found! installing now .." 
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Add Homebrew to your PATH in ~/.zprofile:
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
echo 'export PATH="/usr/local/sbin:$PATH"' >> ~/.zprofile

brew doctor
if [[ $? == 0 ]] ; then
    echo "✅  Brew is ready to go!" 
else
    echo "❌ Something is wrong with Brew!! Check the info above!" 
fi

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Switch to using brew-installed bash as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;

brew tap homebrew/bundle
# brew tap "homebrew/cask" --force

# set arguments for all 'brew install --cask' commands
# cask_args appdir: "~/Applications", require_sha: true

#install stuff with brew
brew install \
  cmake	\
  ;
echo "\n#########################################################"
echo "ALERT! 🚦 This will take some time! ⏰ Just wait 🫶 ..." 
###############################################################################
# macOS
###############################################################################
echo "\n🛠️ Installing General macOS stuffs" 

#  GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed
# Install a modern version of Bash.
brew install bash
brew install bash-completion2

brew install --cask numi # Calculator and converter application
brew install pv # Monitor data's progress through a pipe
brew install ffmpeg

brew install tree # Display directories as trees (with optional color/HTML output)

# generic colouriser  http://kassiopeia.juls.savba.sk/~garabik/software/grc/
brew install grc

brew install --cask quicklook-json
brew install --cask suspicious-package
###############################################################################
# DEV
###############################################################################
echo "\n#########################################################"
echo "🛠️ Installing DEV deps" 

brew install zsh
brew install --cask iterm2
brew install node # This installs `npm` too using the recommended installation method
brew install --cask imageoptim # image reducer/optimazer
brew install --cask imagealpha # Utility to reduce the size of 24-bit PNG files
brew install git
brew install git-lfs
brew install python3
brew install pygments # For syntax highlighting in c (instead cat)
brew install thefuck
brew install pcre
brew install cocoapods

brew install wget #--enable-iri # Install `wget` with IRI support.

brew install gnupg # Install GnuPG to enable PGP-signing commits.

# Install more recent versions of some macOS tools.
brew install grep
brew install openssh
brew install screen
#brew install php
brew install gmp

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

###############################################################################
# Visual Studio Code                 
###############################################################################
echo "\n#########################################################"
echo "🛠️ Installing Visual Studio Code" 
brew install --cask visual-studio-code

cat << EOF >> ~/.bash_profile
# Add Visual Studio Code (code)
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
EOF
cat << EOF >> ~/.zprofile
# Add Visual Studio Code (code)
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
EOF

# Remove outdated versions from the cellar.
brew cleanup