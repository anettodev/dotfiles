#!/usr/bin/env bash
# check if Brew is installed then update; else install Brew
which -s brew
if [[ $? == 0 ]] ; then
    echo "✅  brew already installed! Updating Brew and Upgrading any already-installed formulae .." 
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

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed #--with-default-names
# Install a modern version of Bash.
brew install bash
brew install bash-completion2

# Switch to using brew-installed bash as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;

# Install `wget` with IRI support.
brew install wget #--with-iri

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

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

# Install some CTF tools; see https://github.com/ctfs/write-ups.
# brew install aircrack-ng
# brew install bfg
# brew install binutils
# brew install binwalk
# brew install cifer
# brew install dex2jar
# brew install dns2tcp
# brew install fcrackzip
# brew install foremost
# brew install hashpump
# brew install hydra
# brew install john
# brew install knock
# brew install netpbm
# brew install nmap
# brew install pngcheck
# brew install socat
# brew install sqlmap
# brew install tcpflow
# brew install tcpreplay
# brew install tcptrace
# brew install ucspi-tcp # `tcpserver` etc.
# brew install xpdf
# brew install xz

# Install other useful binaries.
#brew install ack
#brew install exiv2
brew install git
brew install git-lfs
brew install gs
brew install imagemagick #--with-webp
brew install ffmpeg
# brew install lua
# brew install lynx
# brew install p7zip
# brew install pigz
brew install pv
brew install rename
#brew install rlwrap
brew install ssh-copy-id
brew install tree
brew install grc
brew install vbindiff
brew install zopfli

brew install node # This installs `npm` too using the recommended installation method
brew install python3
sudo ln -s /usr/bin/python3 /usr/local/bin/python
brew install pygments # For syntax highlighting in c (instead cat)
brew install thefuck
brew install pcre
brew install cocoapods
brew install carthage

brew install --cask iterm2
brew install --cask numi # Calculator and converter application
brew install --cask quicklook-json
brew install --cask suspicious-package
brew install --cask imageoptim # image reducer/optimazer
brew install --cask imagealpha # Utility to reduce the size of 24-bit PNG files
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