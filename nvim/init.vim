" This is Daniel Puglisi's .vimrc file

" Save yourself a lot of pain by leaving this at the top...
set nocompatible
filetype off " required

" ############################################################################
" PLUG (https://github.com/junegunn/vim-plug)
" ############################################################################
call plug#begin('~/.config/nvim/plugged')

" Core
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'mileszs/ack.vim'

" Utils
Plug 'benmills/vimux'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'rizzatti/funcoo.vim'
Plug 'rizzatti/dash.vim'
Plug 't9md/vim-ruby-xmpfilter'
Plug 'AndrewRadev/splitjoin.vim'

" Ruby & Rails
Plug 'skalnik/vim-vroom'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'danchoi/ri.vim'
Plug 'tpope/vim-endwise'

" HTML & CSS & Others
Plug 'kchmck/vim-coffee-script'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'digitaltoad/vim-jade'

" Markdown etc.
Plug 'tpope/vim-markdown'
Plug 'duwanis/tomdoc.vim'

" Colorschemes
Plug 'chriskempson/base16-vim'

" Writing
Plug 'vimwiki/vimwiki'
Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-pencil'

" Experimental
Plug 'bling/vim-bufferline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'mileszs/ack.vim'

Plug 'godlygeek/tabular'
Plug 'neomake/neomake'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'fishbullet/deoplete-ruby'

" All of your Plugins must be added before the following line
call plug#end()              " required
filetype plugin indent on    " required

" ############################################################################
" BASIC CONFIGURATION
" ############################################################################
filetype plugin indent on
syntax on

set autoindent
set nocursorcolumn
set nocursorline
set backspace=indent,eol,start
set cmdheight=1
set encoding=utf-8
set expandtab
set formatoptions+=n
set hidden
set hlsearch
set ignorecase smartcase
set incsearch
set laststatus=2
set history=1000
set nolazyredraw
set noshowcmd
set nosmarttab
set nostartofline
set nowrap
set number
set report=0
set scrolloff=3
set shell=zsh
set shiftwidth=2
set shortmess=filtIoOA
set showmatch
set showtabline=1
set smartindent
set softtabstop=2
set switchbuf=useopen
set tabstop=4
set virtualedit=block
set whichwrap+=<,>,h,l,[,]
set wildmenu
set wildmode=longest,list
set foldmethod=syntax
set foldlevelstart=20

" Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" ############################################################################
" COLOR STUFF
" ############################################################################
" gui colors if running iTerm
if has("nvim")
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  set termguicolors
end

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" ############################################################################
" CUSTOM AUTOCMDS
" ############################################################################
" ---------------------------------------------------------------------------
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
  autocmd FileType python set sw=4 sts=4 et
  " autocmd FileType ruby match OverLength /\%81v.\+/
  " autocmd FileType markdown match OverLength /\%81v.\+/

  " Sass
  autocmd! BufRead,BufNewFile *.sass setfiletype sass

  " Markdown
  autocmd BufRead *.md  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

  " Ruby
  " autocmd Filetype ruby map <leader>r :VroomRunTestFile<CR>
  " autocmd Filetype ruby map <leader>R :VroomRunNearestTest<CR>
  autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
  autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
  autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

  " Velocity
  autocmd! BufRead,BufNewFile *.vm set filetype=velocity

augroup END
" ---------------------------------------------------------------------------

" VimWiki
" ---------------------------------------------------------------------------
augroup vimwiki_settings
  autocmd!
  autocmd FileType vimwiki setlocal wrap linebreak nolist textwidth=0 wrapmargin=0
  let g:vimwiki_folding='syntax'
augroup END
" ---------------------------------------------------------------------------

" Pencil
" ---------------------------------------------------------------------------
" augroup pencil
"   autocmd!
"   " autocmd FileType markdown,mkd,md call pencil#init({'wrap': 'hard'})
"   " autocmd FileType text         call pencil#init({'wrap': 'soft'})
" augroup END
" ---------------------------------------------------------------------------

" ############################################################################
" REMAPPING
" ############################################################################

" Default mappings
" ---------------------------------------------------------------------------
let mapleader = ","
map WW :w!<CR>

nnoremap Q gqap
vnoremap Q gq
"sane movement with wrap turned on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
" ---------------------------------------------------------------------------

" Map ,e and ,v to open files in the same directory as the current file
" ---------------------------------------------------------------------------
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>V :view %%
" ---------------------------------------------------------------------------

" Search for open Todos inside the directory structure
" ---------------------------------------------------------------------------
map <leader>N :Ag --ignore-dir=log 'TODO\|FIXME\|CHANGED\|NOTE' *<CR>
" ---------------------------------------------------------------------------

" BUFFERS N SHIT, BECAUSE FUCK TABS
" ---------------------------------------------------------------------------
map <C-t> :enew<CR>
map <C-l> :bnext<CR>
map <C-h> :bprevious<CR>
map <leader>x :bp <BAR> bd #<CR>
map <leader>bl :ls<CR>
" ---------------------------------------------------------------------------

" Commentary
" ---------------------------------------------------------------------------
map \\ :Commentary<CR>
" ---------------------------------------------------------------------------

" FZF
" ---------------------------------------------------------------------------
" Ignore rules can be changed in .zshrc. Read more here:
" https://github.com/junegunn/fzf#respecting-gitignore-hgignore-and-svnignore
nnoremap <C-p> :FZF<cr>
" ---------------------------------------------------------------------------

" NERDTree
" ---------------------------------------------------------------------------
map <C-n> :NERDTreeToggle<CR>
" ---------------------------------------------------------------------------

" RI Documentation lookup
" ---------------------------------------------------------------------------
nnoremap  ,di :call ri#OpenSearchPrompt(0)<cr> " horizontal split
nnoremap  ,DI :call ri#OpenSearchPrompt(1)<cr> " vertical split
nnoremap  ,DK :call ri#LookupNameUnderCursor()<cr> " keyword lookup
" ---------------------------------------------------------------------------

" MISC KEY MAPS
" ---------------------------------------------------------------------------
" clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>
" ---------------------------------------------------------------------------

" Shortcut to rapidly toggle `set list
" ---------------------------------------------------------------------------
nmap <leader>l :set list!<cr>
" ---------------------------------------------------------------------------

" OS X Specific
" ---------------------------------------------------------------------------
" Open the file using Marked.app => Good for previewing MARKDOWN files
map <leader>mp :!open -a /Applications/Marked.app '%'<cr>
" ---------------------------------------------------------------------------

" Goyo & Pencil
" ---------------------------------------------------------------------------
map <F10> :Goyo <bar> :TogglePencil <CR>
map <F9> :setlocal spell! spelllang=en_us<CR>
" ---------------------------------------------------------------------------

" ############################################################################
" FUNCTIONS
" ############################################################################

" SWITCH BETWEEN TEST AND PRODUCTION CODE
" ---------------------------------------------------------------------------
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    let new_file = substitute(new_file, '\.rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    end
  endif
  return new_file
endfunction
nnoremap <leader>. :call OpenTestAlternate()<cr>
" ---------------------------------------------------------------------------

" STRIP ALL TRAILING WHITESPACE
" ---------------------------------------------------------------------------
function! StripWhitespace ()
  exec ':%s/ \+$//gc'
endfunction
map ,s :call StripWhitespace ()<CR>

highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/
" ---------------------------------------------------------------------------

" RENAME CURRENT FILE
" ---------------------------------------------------------------------------
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>n :call RenameFile()<cr>
" ---------------------------------------------------------------------------

" ####################
" PLUGIN CONFIGURATION
" ####################

" Vroom
" ---------------------------------------------------------------------------
let vroom_detect_spec_helper = 1
let g:vroom_use_vimux = 1 "enable vimux for vroom
let g:vroom_use_spring = 1 "enable spring by default
let g:VimuxUseNearestPane = 1
let g:vroom_use_colors = 1

map <leader>r :! spring rake test %<CR>
" ---------------------------------------------------------------------------

" Status line
" ---------------------------------------------------------------------------
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
" ---------------------------------------------------------------------------

" ag
" ---------------------------------------------------------------------------
let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack
" ---------------------------------------------------------------------------

" GUI
" ---------------------------------------------------------------------------
if has("gui_running")
set guifont=Inconsolata:h14
set wrap
set linebreak
endif
" ---------------------------------------------------------------------------

" Airline
" ---------------------------------------------------------------------------
set noshowmode
let g:airline_powerline_fonts=1
let g:bufferline_echo = 0
let g:airline_section_c = ''
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_mode_map = {'c': 'C', '^S': 'S', 'R': 'R', 's': 'S', 't': 'T', 'V': 'VL', '^V': 'VB', 'i': 'I', '__': '------', 'S': 'SL', 'v': 'V', 'n': 'N'}
let g:airline_section_z = ''
let g:airline_right_alt_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_buffers = 1
" ---------------------------------------------------------------------------

" Neomake
" ---------------------------------------------------------------------------
autocmd! BufWritePost * Neomake
" ---------------------------------------------------------------------------

" Deoplete
" ---------------------------------------------------------------------------
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#disable_auto_complete = 1
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" deoplete tab-complete
inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ deoplete#mappings#manual_complete()
          function! s:check_back_space() abort "{{{
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~ '\s'
          endfunction"}}}
" ---------------------------------------------------------------------------

" VARIOUS
" ---------------------------------------------------------------------------
let g:netrw_home = $HOME
" ---------------------------------------------------------------------------
