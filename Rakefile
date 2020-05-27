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
    "homebrew-cask-fonts",
    "heroku/brew"
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
    "fzf",
    "the_silver_searcher",
    "heroku",
    "python",
    "python@2",
    "postgresql",
    "p7zip",
    "imagemagick",
    "puma/puma/puma-dev",
    "potrace",
    "nodejs",
    "yarn"
  ]

  brew_casks = [
    "iterm2",
    "brave-browser",
    "rectangle",
  ]

  brew_fonts = [
    "font-roboto-mono"
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
    system("brew cask install #{cask}")
  end
end
