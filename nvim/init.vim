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
Plug 'tpope/vim-rhubarb'
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
Plug 'base16-project/base16-vim'

" Writing
" Plug 'vimwiki/vimwiki'
Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-pencil'

" Experimental
Plug 'bling/vim-bufferline'
Plug 'scrooloose/nerdtree'
Plug 'mileszs/ack.vim'

Plug 'godlygeek/tabular'
Plug 'neomake/neomake'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'iamcco/coc-tailwindcss',  {'do': 'yarn install --frozen-lockfile && yarn run build'}
" Plug 'rodrigore/coc-tailwind-intellisense', {'do': 'yarn install --frozen-lockfile && yarn run build'}
Plug 'rodrigore/coc-tailwind-intellisense', {'do': 'npm install'}

Plug 'ngmy/vim-rubocop'

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
  autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
  autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
  autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

  " Velocity
  autocmd! BufRead,BufNewFile *.vm set filetype=velocity

augroup END
" ---------------------------------------------------------------------------

" VimWiki
" ---------------------------------------------------------------------------
" augroup vimwiki_settings
"   autocmd!
"   autocmd FileType vimwiki setlocal wrap linebreak nolist textwidth=0 wrapmargin=0
"   let g:vimwiki_folding='syntax'
" augroup END
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
let g:vroom_map_keys = 1 "Disable Vroom
let g:vroom_use_colors = 1
let g:vroom_use_vimux = 1
let g:vroom_use_terminal = 0
let g:vroom_clear_screen = 0
let g:vroom_test_unit_command = 'bin/rails test'
let g:vroom_use_bundle_exec = 0

autocmd Filetype ruby map <leader>r :VroomRunTestFile<CR>
autocmd Filetype ruby map <leader>R :VroomRunNearestTest<CR>
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

" Neomake
" ---------------------------------------------------------------------------
autocmd! BufWritePost * Neomake
" ---------------------------------------------------------------------------

" Coc
" ---------------------------------------------------------------------------
"
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <ci> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CI>"
else
  inoremap <expr> <ci> pumvisible() ? "\<C-y>" : "\<C-g>u\<CI>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" ---------------------------------------------------------------------------


" VARIOUS
" ---------------------------------------------------------------------------
let g:netrw_home = $HOME
" ---------------------------------------------------------------------------
