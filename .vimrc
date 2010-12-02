" ==== DEBIAN SPECIFICS ====
" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim


set loadplugins

" ==== COLORS ====
syntax on
set background=dark

" set number of colors to 256
set t_Co=256

" colorschemes /w 256-colors
"colorscheme gardener
colorscheme desert256
"colorscheme inkpot
"colorscheme charged256
"colorscheme jellybeans


" ==== HIGHLIGHTS ====
" spellchecking
" :set spell spelllang=de

" prefix wrapped lines (we dont like this anymore..)
" set sbr=++\ 

" mark too long lines
"augroup vimrc_autocmds
"  autocmd BufRead * highlight OverLength ctermbg=darkgrey guibg=#592929
"  autocmd BufRead * match OverLength /\%72v.*/
"augroup END

" do not search highlighted
set nohlsearch

" add ExtraWhitespace-group, set colors of that 
highlight ExtraWhitespaceTrail term=standout ctermfg=15 ctermbg=1 guifg=White guibg=Red
highlight ExtraWhitespaceBefore term=standout ctermfg=15 ctermbg=1 guifg=White guibg=Red
"highlight ExtraWhitespaceTab term=standout ctermfg=15 ctermbg=1 guifg=White guibg=Red
"highlight ExtraWhitespaceExtra term=standout ctermfg=15 ctermbg=1 guifg=White guibg=Red
" light grey:
"highlight ExtraWhitespace ctermfg=238 ctermbg=234

" Show trailing whitespace:
match ExtraWhitespaceTrail /\s\+$/

" Show trailing whitepace and spaces before a tab:
match ExtraWhitespaceBefore /\s\+$\| \+\ze\t/

" Show tabs that are not at the start of a line:
"match ExtraWhitespaceTab /[^\t]\zs\t\+/

" Show spaces used for indenting (so you use only tabs for indenting).
"match ExtraWhitespaceExtra /^\t*\zs \+/

" show spaces on leaving insert-mode
"autocmd InsertLeave * redraw!
"autocmd ColorScheme * highlight ExtraWhitespace ctermfg=darkgreen ctermbg=darkgreen
"autocmd InsertEnter * 2match trailExtraWhiteSpace /\s\+\%#\@<!$/


" Show  tab characters. Visual Whitespace.
set list
set listchars=tab:>.



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


" ===== TABS & SPACES ====
" soft-tabstop (what we see)
set sts=4
" tabstop (what will be written)
set ts=4
" amount of spaces per tab
set sw=4
if $HOSTNAME =~ "jim3"
	" inserts spaces instead of tabs on line-beginning
	set smarttab
	" no expandtab (tabs = spaces = :ugly:, tabs should always be tabs)
	set et
else
	" inserts spaces instead of tabs on line-beginning
	set nosmarttab
	" no expandtab (tabs = spaces = :ugly:, tabs should always be tabs)
	set et
endif

" load indentation rules according to the detected filetype.
if has("autocmd")
	filetype indent on
endif

filetype on            " enables filetype detection
filetype plugin on     " enables filetype specific plugins




" ==== EDITING & MOVING & BINDS ====
" always keep 3 lines an bottom/top
set so=3

" map to indexlisting/explorer
" horizontal split (above)
map <F2> :Hexplore!<CR>
" open new tab
map <F3> :Texplore!<CR>

" bind <ALT>-LEFT / <ALT>-RIGHT to move complete tab to left/right
" FIXME eventually change noremap to map
noremap <silent> <M-Left> :exe "silent! tabmove " . (tabpagenr() - 2)<CR>
noremap <silent> <M-Right> :exe "silent! tabmove " . tabpagenr()<CR>


set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden         " Hide buffers when they are abandoned
set mouse=			" disable the fsckn mouse

" Folkes magic  # adder/remover 
" was vnoremap
noremap # :s/^\([ \t]*\)\(.*\)$/\1#\2<cr>:nohl<cr>:silent! set hl<CR>
noremap 3 :s/^\([ \t]*\)#\(.*\)$/\1\2<cr>:nohl<cr>:silent! set hl<CR>

set pastetoggle=<F11>


" show doiff to original file
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" folding with F9
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

" " Here is an alternative procedure: In normal mode, press Space to toggle the
" " current fold open/closed. However, if the cursor is not in a fold, move to
" " the right (the default behavior). In addition, with the manual fold method,
" " you can create a fold by visually selecting some lines, then pressing Space.
" nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
" vnoremap <Space> zf

" ==== COMPLETION ====
" folding by syntax
set fdm=syntax

" DOCU ME
set wildmenu
set wildmode=list:longest,full

" do not move instantly to search-result
set nois

" we are not vi-compatible
set nocompatible

" jump to the last position when reopening a file
if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
		\| exe "normal g'\"" | endif
endif






" ==== MENU & BARS ====
"set statusline=%{GitBranchInfoString} 
set statusline=%#StatusLineNC#\ Git\ %#ErrorMsg#\ %{GitBranchInfoTokens()[0]}\ %#StatusLine#
set laststatus=2
set number
set showcmd			" Show (partial) command in status line.
set showmode		" Insert, Replace or Visual mode put a message on the last line


" ==== COMPILING & ETC ====
augroup PO
	autocmd FileType po compiler po
augroup END 


" ==== GVIM SPECIFIC ====
set guifont=Bitstream\ Vera\ Sans\ mono\ 9
"set guioptions-=m
"set guioptions-=T
"set guioptions-=r
"map <UP> gk
"map <DOWN> gj

" ==== sup mailclient ====
" syntax coloration when composing emails
au BufRead sup.*        set ft=mail
set modeline
