require 'rake'

desc "Install all the dependencies for these dotfiles using Homebrew"
task :dependencies do
  # Check if we have Homebrew installed:
  unless system("which brew 2>&1 > /dev/null")
    puts "Homebrew is not Installed!"
    puts "Install it first: https://github.com/mxcl/homebrew/wiki/installation"
    exit(1)
  end

  brew_taps = [
    "heroku/brew",
    "homebrew/cask-fonts",
    "petere/postgresql"
  ]

  brew_recipes = [
    "zsh",
    "neovim",
    "git",
    "svn",
    "hub",
    "bash-completion",
    "coreutils",
    "tmux",
    "reattach-to-user-namespace",
    "ctags",
    "curl",
    "rbenv",
    "ruby-build",
    "nodenv",
    "pyenv",
    "fzf",
    "the_silver_searcher",
    "heroku",
    "doctl",
    "flyctl",
    "python",
    "python@2",
    "p7zip",
    "imagemagick",
    "vips",
    "puma/puma/puma-dev",
    "potrace",
    "nodejs",
    "yarn",
    "redis",
    "petere/postgresql/postgresql-common",
    "petere/postgresql/postgresql@14",
    "petere/postgresql/postgresql@15",
    "ffmpeg"
  ]

  brew_casks = [
    "alacritty",
    "brave-browser",
    "rectangle",
  ]

  brew_fonts = [
    "font-roboto-mono",
    "font-montserrat",
    "font-inter"
  ]

  brew_taps.each do |tap|
    puts "Tapping into #{tap}..."
    system("brew tap #{tap}")
  end

  brew_recipes.each do |recipe|
    puts "Installing #{recipe}..."
    system("brew install #{recipe}")
  end

  (brew_casks + brew_fonts).each do |cask|
    puts "Installing cask #{cask}..."
    system("brew install --cask #{cask}")
  end

  puts "Install rbenv-default-gems"
  system("git clone https://github.com/rbenv/rbenv-default-gems.git $(rbenv root)/plugins/rbenv-default-gems")
end
