" ==== DEBIAN SPECIFICS ====
" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" ==== plugins via plug.vim ====
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'Finkregh/vim-dnstools'
Plug 'clones/vim-autocomplpop'
Plug 'altercation/vim-colors-solarized'
Plug 'clones/vim-l9'
Plug 'taq/vim-git-branch-info'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'chr4/sslsecure.vim'
Plug 'fatih/vim-go'
Plug 'w0rp/ale'
" this breaks yaml files..
"Plug 'MicahElliott/Rocannon'

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
"Plug 'junegunn/vim-easy-align'

" Multiple Plug commands can be written in a single line using | separators
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Initialize plugin system
call plug#end()

" ==== generics ====
set hidden
let g:mapleader = ","
set encoding=utf-8
set fileformats=unix,dos,mac "Default file types

"Set backup to a location
set backup
set backupdir=$HOME/temp/vim_backups//,~/tmp//,/var/tmp//,/tmp//
set directory=$HOME/temp/vim_swp//,~/tmp//,/var/tmp/tmp//,/tmp//
set undodir=$HOME/temp/vim_undo//,~/tmp//,/var/tmp//,/tmp//
"set noswapfile

set loadplugins
set nocompatible " we are not vi-compatible

"""" Editing
set backspace=2							" Backspace over anything! (Super backspace!)
set matchtime=2							" For .2 seconds
set formatoptions-=tc					" I can format for myself, thank you very much
set nosmartindent
"set autoindent
set cindent
set showbreak=↳                         " display dots in front of wrapped lines
set breakindent                         " indent warpped lines
set matchpairs+=<:>						" specially for html
set showmatch							" Briefly jump to the previous matching parent

set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set noincsearch		" Incremental search
set hlsearch        " highlight search (remove highlight /w CTRL-l
"set autowrite		" Automatically save before commands like :next and :make
"set hidden         " Hide buffers when they are abandoned
set mouse=			" disable the fsckn mouse

"""" Coding
set history=1000						" 100 Lines of history
set showfulltag							" Show more information while completing tags
filetype plugin indent on				" Let filetype plugins indent for me



""" Windows
if exists(':tab')						" Try to move to other windows if changing buf
set switchbuf=useopen,usetab
else									" Try other windows & tabs if available
	set switchbuf=useopen
endif

" ==== TABS & SPACES ===
au BufRead,BufNewFile *.py  set ai sw=4 sts=4 et tw=72 " Doc strs
au BufRead,BufNewFile *.js  set ai sw=2 sts=2 et tw=72 " Doc strs
au BufRead,BufNewFile *.html set ai sw=2 sts=2 et tw=72 " Doc strs
au BufRead,BufNewFile *.json set ai sw=4 sts=4 et tw=72 " Doc strs
au BufNewFile *.html,*.py,*.pyw,*.c,*.h,*.json set fileformat=unix
au! BufRead,BufNewFile *.json setfiletype json 

" soft-tabstop (what we see)
set sts=4
" tabstop (what will be written)
set ts=4
" amount of spaces per tab
set sw=4
" inserts spaces instead of tabs on line-beginning
set smarttab
" no expandtab (tabs = spaces = :ugly:, tabs should always be tabs)
set et

" set up tags
set tags=tags;~/
set tags+=$HOME/.vim/tags/python.ctags

""" Abbreviations
function! EatChar(pat)
	let c = nr2char(getchar(0))
	return (c =~ a:pat) ? '' : c
endfunc

"endif


" Let abbreviations be in its own file
" ------------------------------------

if filereadable(expand("~/.vim/abbr"))
	source ~/.vim/abbr
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cope
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Do :help cope if you are unsure what cope is. It's super useful!
map <leader>cc :botright cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>
" just subsitute ESC with ,
map <leader> ,

"fast copy

nmap <leader>y "*y
nmap <leader>Y "yy
nmap <leader>p "*p
nmap <leader>0 "0p
nmap <leader>1 "1p
nmap <leader>2 "2p
nmap <leader>3 "3p
nmap <leader>4 "4p
nmap <leader>5 "5p
nmap <leader>6 "6p
nmap <leader>7 "7p
nmap <leader>8 "8p
nmap <leader>9 "9p
"show registers
nmap <leader>r :registers<CR>

""""" Folding
set foldmethod=syntax                   " indent via syntax
set foldlevelstart=99					" All folds open by default
set foldenable

"""" Command Line
set wildmenu							" Autocomplete features in the status bar
set wildmode=longest:full,list
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn

" ==== Autocommands ====
autocmd FileType python compiler pylint
autocmd FileType po compiler po
autocmd BufWrite *.py :call DeleteTrailingWS()
" jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif

" In plain-text files and svn commit buffers, wrap automatically at 78 chars
au FileType text,svn setlocal tw=78 fo+=t

" In all files, try to jump back to the last spot cursor was in before exiting
au BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\   exe "normal g`\"" |
	\ endif

" Use :make to check a script with perl
au FileType perl set makeprg=perl\ -c\ %\ $* errorformat=%f:%l:%m

" Use :make to compile c, even without a makefile
au FileType c,cpp if glob('Makefile') == "" | let &mp="gcc -o %< %" | endif

" Switch to the directory of the current file, unless it's a help file.
au BufEnter * if &ft != 'help' | silent! cd %:p:h | endif

" Insert Vim-version as X-Editor in mail headers
au FileType mail sil 1  | call search("^$")
			 \ | sil put! ='X-Editor: Vim-' . Version()
" smart indenting for python
au FileType python set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
set iskeyword+=.,_,$,@,%,#
au FileType python set expandtab
" setup file type for snipmate
"--------------------------------------------------------------------------
" au FileType python set ft=python.django
au FileType xhtml set ft=htmldjango.html
au FileType html set ft=htmldjango.html

" kill calltip window if we move cursor or leave insert mode
au CursorMovedI * if pumvisible() == 0|pclose|endif
au InsertLeave * if pumvisible() == 0|pclose|endif

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python.django set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType htmldjango.html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" ==== colors/display ====
syntax on
let python_highlight_all=1

" Bad hitespace
highlight BadWhitespace ctermbg=red guibg=red
" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" OO
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.yml match BadWhitespace /\s\+$/
" ansible
au BufNewFile,BufRead * if s:isAnsible() | set ft=ansible | en
"au BufNewFile,BufRead *.j2 set ft=ansible_template
"au BufNewFile,BufRead hosts set ft=ansible_hosts


filetype plugin indent on
set iskeyword+=.

" == display ==
set background=dark                     " I use dark background
set lazyredraw                          " Don't repaint when scripts are running
set scrolloff=3                         " Keep 3 lines below and above the cursor
set ruler                               " line numbers and column the cursor is on
set number                              " Show line numbering
set numberwidth=1                       " Use 1 col + 1 space for numbers
set ttyfast

" set number of colors to 256
set t_Co=256

" colorschemes /w 256-colors
"colorscheme gardener
"colorscheme desert256
"colorscheme inkpot
"colorscheme charged256
"colorscheme jellybeans
"colorscheme solarized
set background=dark                     " I use dark background


" ==== HIGHLIGHTS ====
" spellchecking
" :set spell spelllang=de

" Show  tab characters. Visual Whitespace.
"set list
"set listchars=tab:>.

" highlight some things in comments
let c_comment_strings = 1
" SQL-Highlighting in PHP-Strings (1=yes 0=no)
let php_sql_query = 1
let php_minlines=300
let php_htmlInStrings=1


" ===== ENCODING ====
" we are UTF-8
set encoding=utf-8
set termencoding=utf-8

" ==== COMMANDS ====
" switch to directory of current file
command! CD cd %:p:h

" Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

function! s:isAnsible()
  let l:filepath = expand('%:p')
  let l:filename = expand('%:t')
  if l:filepath =~ '\v/(tasks|roles|handlers)/.*\.ya?ml$' | return 1 | en
  if l:filepath =~ '\v/(group|host)_vars/' | return 1 | en
  if l:filename =~ '\v(playbook|site|main|local)\.ya?ml$' | return 1 | en

  let l:shebang = getline(1)
  if l:shebang =~# '^#!.*/bin/env\s\+ansible-playbook\>' | return 1 | en
  if l:shebang =~# '^#!.*/bin/ansible-playbook\>' | return 1 | en

  return 0
endfunction

" ==== EDITING & MOVING & BINDS/MAPPINGS ====
"""" Movement
" work more logically with wrapped lines
noremap j gj
noremap k gk

"""" Key Mappings
" bind ctrl+space for omnicompletion
inoremap <Nul> <C-x><C-o>
imap <c-space> <C-x><C-o>

" Toggle the tag list bar
nmap <F4> :TlistToggle<CR>
nmap <F8> :NERDTreeToggle<CR>

"Format
au FileType xml map <F9> :silent 1,$!xmllint --format --recover - 2>/dev/null<CR>
" tab navigation (next tab) with alt left / alt right

" Extra functionality for some existing commands:
" <C-6> switches back to the alternate file and the correct column in the line.
nnoremap <C-6> <C-6>`"

" CTRL-g shows filename and buffer number, too.
nnoremap <C-g> 2<C-g>

" <C-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Q formats paragraphs, instead of entering ex mode
noremap Q gq

" * and # search for next/previous of selected text when used in visual mode
vnoremap * y/<C-R>"<CR>
vnoremap # y?<C-R>"<CR>

" <space> toggles folds opened and closed
nnoremap <space> za

" <space> in visual mode creates a fold over the marked range
vnoremap <space> zf

" allow arrow keys when code completion window is up
inoremap <Down> <C-R>=pumvisible() ? "\<lt>C-N>" : "\<lt>Down>"<CR>

" map to indexlisting/explorer
" horizontal split (above)
map <F2> :Hexplore<CR>
" open new tab
map <F3> :Texplore<CR>

" bind <ALT>-LEFT / <ALT>-RIGHT to move complete tab to left/right
" FIXME eventually change noremap to map
noremap <silent> <M-Left> :exe "silent! tabmove " . (tabpagenr() - 2)<CR>
noremap <silent> <M-Right> :exe "silent! tabmove " . tabpagenr()<CR>

" movement remaps
" ------------------------------------------
nnoremap  <a-right>  gt
nnoremap  <a-left>   gT

" Ctrl + Arrows - Move around quickly
nnoremap  <c-up>     {
nnoremap  <c-down>   }
nnoremap  <c-right>  El
nnoremap  <c-down>   Bh

" Shift + Arrows - Visually Select text
nnoremap  <s-up>     Vk
nnoremap  <s-down>   Vj
nnoremap  <s-right>  vl
nnoremap  <s-left>   vh

nnoremap ' `
nnoremap ` '

" " Folkes magic  # adder/remover
" " was vnoremap
" noremap # :s/^\([ \t]*\)\(.*\)$/\1#\2<cr>:nohl<cr>:silent! set hl<CR>
" noremap 3 :s/^\([ \t]*\)#\(.*\)$/\1\2<cr>:nohl<cr>:silent! set hl<CR>

set pastetoggle=<F11>

" show diff to original file
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" folding with F9
inoremap <F10> <C-O>za
nnoremap <F10> za
onoremap <F10> <C-C>za
vnoremap <F10> zf

" Here is an alternative procedure: In normal mode, press Space to toggle the
" current fold open/closed. However, if the cursor is not in a fold, move to
" the right (the default behavior). In addition, with the manual fold method,
" you can create a fold by visually selecting some lines, then pressing Space.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
vnoremap <Space> zf

" ==== COMPLETION ====
" folding by syntax
"set fdm=syntax


" ==== MENU & BARS ====
"set statusline=%{GitBranchInfoString}
set statusline=%#StatusLineNC#\ Git\ %#ErrorMsg#\ %{GitBranchInfoTokens()[0]}\ %#StatusLine#\ \|\ %<%f\ [%R%M%Y]\ %=\[%b\|0x%B\]\ \ [l:%l,col:%c%V\ %P]
set laststatus=2    " Always show statusline, even if only 1 window
set showcmd         " Show (partial) command in status line.
set showmode        " Insert, Replace or Visual mode put a message on the last line

"""" Messages, Info, Status
set shortmess+=a    " Use [+] [RO] [w] for modified, read-only, modified
set report=0        " Notify me whenever any lines have changed
set confirm         " Y-N-C prompt if closing with unsaved changes
set vb t_vb=        " Disable visual bell!  I hate that flashing.

" tab labels show the filename without path(tail)
set guitablabel=%N/\ %t\ %M

" ==== COMPILING & ETC ====
augroup PO
augroup END


" ==== GVIM SPECIFIC ====
if has("gui_running")
    syntax enable
    set t_Co=256
    set hlsearch
    set clipboard=autoselect
    set guioptions+=T
    set toolbar=icons,tooltips
    "set guifont=DejaVu\ Sans\ Mono
    set guifont=Bitstream\ Vera\ Sans\ mono\ 9
    "set guifont=Inconsolata\ Medium\ 12
    set nu
    "set guioptions-=m
    "set guioptions-=T
    "set guioptions-=r
endif


" ==== plugin-configs ====

"pyflakes gives me probles on Linux PPC and quickfix, so just 
"deactivate quickfix use with pyflakes
let g:pyflakes_use_quickfix = 0

"" ==== sup mailclient ====
"" syntax coloration when composing emails
"au BufRead sup.*        set ft=mail
"set modeline
"
"
"
"" Taglist variables
"" Display function name in status bar:
"let g:ctags_statusline=1
"" Automatically start script
"let generate_tags=1
"" Displays taglist results in a vertical window:
"let Tlist_Use_Horiz_Window=0
"" Shorter commands to toggle Taglist display
"nnoremap TT :TlistToggle<CR>
"map <F4> :TlistToggle<CR>
"" Various Taglist diplay config:
"let Tlist_Use_Right_Window = 1
"let Tlist_Compact_Format = 1
"let Tlist_Exit_OnlyWindow = 1
"let Tlist_GainFocus_On_ToggleOpen = 1
"let Tlist_File_Fold_Auto_Close = 1
"
"" === vim-branch-info ===
"let g:git_branch_status_head_current=1
"let g:git_branch_status_ignore_remotes=1

" === ale ===
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'sh': ['shfmt'],
\}
" always show gutter-line (remove pop-in-pop-out flicker)
let g:ale_sign_column_always = 1

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:ale_sh_shfmt_options = '-i 4'

"" === vim-pythonhelper ===
"highlight PyHelperStatus ctermbg=245 ctermfg=000
"
" === pack management (vim 8) ===
packloadall

silent! helptags ALL
