
" ===== ENCODING ====
" we are UTF-8
set encoding=utf-8
set termencoding=utf-8


" ===== TABS & SPACES ====
" soft-tabstop (what we see)
set sts=4
" tabstop (what will be written)
set ts=4
" no expandtab (tabs = spaces = :ugly:, tabs should always be tabs)
set noet
" amount of spaces per tab
set sw=4
" inserts spaces instead of tabs on line-beginning
set nosmarttab

" load indentation rules according to the detected filetype.
if has("autocmd")
	filetype indent on
endif



" ==== HIGHLIGHTS ====
" spellchecking
" :set spell spelllang=de

" prefix wrapped lines (we dont like this anymore..)
" set sbr=++\ 

" mark too long lines
"      match ErrorMsg /\%>80v.\+/

" do not search highlighted
set nohlsearch

" add ExtraWhitespace-group, set colors of that
":highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
" light grey:
:highlight ExtraWhitespace ctermfg=238 ctermbg=234

" Show trailing whitespace:
:match ExtraWhitespace /\s\+$/

" Show trailing whitepace and spaces before a tab:
:match ExtraWhitespace /\s\+$\| \+\ze\t/

" Show tabs that are not at the start of a line:
:match ExtraWhitespace /[^\t]\zs\t\+/

" Show spaces used for indenting (so you use only tabs for indenting).
:match ExtraWhitespace /^\t*\zs \+/


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


set showcmd			" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden         " Hide buffers when they are abandoned
set mouse=			" disable the fsckn mouse

" completion
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



" ==== COLORS ====
" set number of colors to 256
set t_Co=256

" colorschemes /w 256-colors
"colorscheme gardener
"colorscheme desert256
"colorscheme inkpot
colorscheme charged256

syntax on
set background=dark



" ==== DEBIAN SPECIFICS ====
" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim


set loadplugins

" ==== MENU & BARS ====
"set statusline=%{GitBranchInfoString} 
set statusline=%#StatusLineNC#\ Git\ %#ErrorMsg#\ %{GitBranchInfoTokens()[0]}\ %#StatusLine#
set laststatus=2


" ==== COMPILING & ETC ====
augroup PO
	autocmd FileType po compiler po
augroup END 

