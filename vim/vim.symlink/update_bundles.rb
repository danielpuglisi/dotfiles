#!/usr/bin/env ruby

git_bundles = [ 
	"git://github.com/vim-scripts/AutoComplPop.git",      # Automatically opens popup menu for completions
	"git://github.com/mileszs/ack.vim.git",               # Vim plugin for the Perl module / CLI script "ack"
	"git://github.com/wincent/Command-T.git",             # Fast file opener
	"git://github.com/scrooloose/nerdtree.git",           # Vim Tree explorer
	"git://github.com/msanders/snipmate.vim.git",         # TextMate Snippets for Vim
	"git://github.com/vim-scripts/taglist.vim.git",       # Source code browser
	"git://github.com/shemerey/vim-peepopen.git",         # Peepopen extension
	"git://github.com/tpope/vim-rails.git",               # Ruby on Rails power tools
	"git://github.com/tpope/vim-surround.git",            # quoting/parenthesizing made simple
	"git://github.com/tpope/vim-fugitive.git",            # Git wrapper
    "git://github.com/timcharper/textile.vim.git",        # Textile for Vim https://raw.github.com/timcharper/textile.vim/master/doc/textile.txt
    "git://github.com/tpope/vim-markdown.git",            # Vim Markdown runtime files
    "git://github.com/tpope/vim-repeat.git",              # enable repeating supported plugin maps with "."
    "git://github.com/scrooloose/nerdcommenter.git",      # Vim plugin for commenting
    "git://github.com/vim-ruby/vim-ruby.git",             # Edit and compile Ruby within Vim.
    "git://github.com/vim-scripts/velocity.vim.git",      # Velocity scripts 
    "git://github.com/vim-scripts/Gist.vim.git",          # Vimscript for gist
]

require 'fileutils'
require 'open-uri'

bundles_dir = File.join(File.dirname(__FILE__), "bundle")

FileUtils.cd(bundles_dir)

puts "Trashing everything (lookout!)"
Dir["*"].each {|d| FileUtils.rm_rf d }

git_bundles.each do |url|
  dir = url.split('/').last.sub(/\.git$/, '')
  puts "  Unpacking #{url} into #{dir}"
  `git clone #{url} #{dir}`
  FileUtils.rm_rf(File.join(dir, ".git"))
end
