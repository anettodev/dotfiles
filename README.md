# ANetto.dev dotfiles
This repo is based in many others dotfiles REPOs. Mainly the [@mathiasbynens REPO](https://github.com/mathiasbynens/dotfiles).

## Installation

**Warning:** Don’t blindly use my settings unless you know what that entails. Use at your own risk!

### Using Git and the setup script

All files gonna stay in `~/.dotfiles`

```bash
git clone git@github.com:anettodev/dotfiles.git ~/.dotfiles
```

To update your system, `cd` into your local `~/.dotfiles` repository and then:

```bash
source bootstrap.sh
```

PS: This will install the basic stuffs like `Xcode`, `Oh My ZSH`, `ZSH plugins`, `.gitconfig`, `powerlevel10k`.

### Brew Deps + macOS flags

You also can run this scripts to install some cool dependencies and macOS system flags:

```bash
source brew.sh
```

```bash
source macos.sh
```