# Vim notes

## Install vim

* `rake dependencies` => installs macvim through homebrew
* `brew linkapps`

## Plugin Management
I am using Tim Popes [pathogen](https://github.com/tpope/vim-pathogen) extension for plugin managmenet.
This keeps my vim directory very lightweight since I can just add functionality via git clone URLs.

### Install Plugins
Startup vim and execute the `:BundleInstall` command.

### Adding new plugins
Edit the file `./vimrc.symlink` and add pathogen supported plugins as git url to the `VUNDLES` chapter.

### Updating / installing plugins

**Important:** Make sure that you don't add plugins manually to the `./vim.symlink/bundle` directory. The
script will purge this directory EVERY TIME you run it.
