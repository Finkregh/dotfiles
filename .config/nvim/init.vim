"" don't use arrowkeys
"noremap <Up> <NOP>
"noremap <Down> <NOP>
"noremap <Left> <NOP>
"noremap <Right> <NOP>
"
"" really, just don't
"inoremap <Up>    <NOP>
"inoremap <Down>  <NOP>
"inoremap <Left>  <NOP>
"inoremap <Right> <NOP>

let g:python2_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

" ==== plugins via plug.vim ====
" FIXME please...
"if !filereadable('$HOME/.local/share/nvim/site/autoload/plug.vim')
"  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
"endif

call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes

Plug 'tpope/vim-fugitive' " git commands
Plug 'clones/vim-autocomplpop' " auto-open completion popup
" Plug 'altercation/vim-colors-solarized'
Plug 'hukl/Smyck-Color-Scheme', { 'do': 'rm ~/.local/share/nvim/plugged/Smyck-Color-Scheme/colors; mkdir ~/.local/share/nvim/plugged/Smyck-Color-Scheme/colors; ln -s ~/.local/share/nvim/plugged/Smyck-Color-Scheme/smyck.vim ~/.local/share/nvim/plugged/Smyck-Color-Scheme/colors/' }
Plug 'clones/vim-l9' " helper library
Plug 'taq/vim-git-branch-info' " info in statusline
Plug 'Glench/Vim-Jinja2-Syntax'
"Plug 'chr4/sslsecure.vim' " SSL cipher highlight
Plug 'fatih/vim-go' " golang stuff
Plug 'w0rp/ale' " async linting engine
Plug 'PProvost/vim-ps1'
" this breaks yaml files..
"Plug 'MicahElliott/Rocannon'
Plug 'christoomey/vim-conflicted' " git conflict solving
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'editorconfig/editorconfig-vim' " respect editorconfig config lines
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
"Plug 'tomtom/tcomment_vim' " proper comment enabling for various files
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'pearofducks/ansible-vim', { 'do': 'cd ./UltiSnips; ./generate.py' }
"Plug 'rhysd/vim-grammarous'

Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' } " IDE for python


" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
"Plug 'junegunn/vim-easy-align'

" Multiple Plug commands can be written in a single line using | separators
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Initialize plugin system
call plug#end()


" ==== generics ====
set hidden
let g:mapleader = ","
let maplocalleader = ","
set encoding=utf-8
set fileformats=unix,dos,mac "Default file types

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
" make markdown break at 80 chars
au BufRead,BufNewFile *.md setlocal textwidth=80

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
colorscheme smyck

" Bad hitespace
highlight BadWhitespace ctermbg=red guibg=red
" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" OO
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.yml match BadWhitespace /\s\+$/
" ansible
au BufNewFile,BufRead * if s:isAnsible() | set ft=yaml.ansible | en
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
set nocursorcolumn
" only enable cursorcolumn on yaml files, otherwise not needed
au BufRead,BufNewFile *.yml set cursorcolumn
au BufRead,BufNewFile *.yaml set cursorcolumn


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

set pastetoggle=<F11>


" show diff to original file
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif
set diffopt+=vertical

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



" ==== plugin-configs ====

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
\   'xml': ['xmllint'],
\   'python': ['black', 'isort'],
\   'php': ['php_cs_fixer', 'phpcbf'],
\}
"   'markdown': ['prettier', 'textlint'],
" always show gutter-line (remove pop-in-pop-out flicker)
let g:ale_sign_column_always = 1

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:ale_sh_shfmt_options = '-i 4'

" lint after 1000ms after changes are made both on insert mode and normal mode
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_delay = 1000

" use nice symbols for errors and warnings
let g:ale_sign_error = '✗ '
let g:ale_sign_warning = '⚠ '

"" === vim-pythonhelper ===
"highlight PyHelperStatus ctermbg=245 ctermfg=000
"
"" === fzf
" make FZF respect gitignore if `ag` is installed
" you will obviously need to install `ag` for this to work
if (executable('ag'))
    let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
endif
nnoremap <C-P> :Files<CR>

" === editorconfig
" properly work with fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" === YouCompleteMe
" disable auto_triggering ycm suggestions pane and instead
" use semantic completion only on Ctrl+n
let ycm_trigger_key = '<C-n>'
let g:ycm_auto_trigger = 0
let g:ycm_key_invoke_completion = ycm_trigger_key

" this is some arcane magic to allow cycling through the YCM options
" with the same key that opened it.
" See http://vim.wikia.com/wiki/Improve_completion_popup_menu for more info.
let g:ycm_key_list_select_completion = ['<TAB>', '<C-j>']
inoremap <expr> ycm_trigger_key pumvisible() ? "<C-j>" : ycm_trigger_key;<Paste>

" === ansible-vim
" two newlines = complete unindent
let g:ansible_unindent_after_newline = 1


" === pack management (vim 8) ===
packloadall
