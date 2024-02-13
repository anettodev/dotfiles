# ANetto.dev dotfiles
This repo is based in many others dotfiles REPOs. Mainly the [@mathiasbynens](https://github.com/mathiasbynens/dotfiles).

## Installation

**Warning:** Don’t blindly use my settings unless you know what that entails. Use at your own risk!

### Using Git and the setup script

You can clone the repository wherever you want. (I like to keep it in `~/Projects/dotfiles`, with `~/dotfiles` as a symlink.) The bootstrapper script will pull in the latest version and copy the files to your home folder.

```bash
git clone git@github.com:anettodev/dotfiles.git && cd dotfiles && source anettoSetup.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
source anettoSetup.sh
```

Alternatively, to update while avoiding the confirmation prompt:

```bash
set -- -f; source anettoSetup.sh
```

### Specify the `$PATH`

If `~/.path` exists, it will be sourced along with the other files, before any feature testing (such as [detecting which version of `ls` is being used](https://github.com/mathiasbynens/dotfiles/blob/aff769fd75225d8f2e481185a71d5e05b76002dc/.aliases#L21-L26)) takes place.

Here’s an example `~/.path` file that adds `/usr/local/bin` to the `$PATH`:

```bash
export PATH="/usr/local/bin:$PATH"
```
