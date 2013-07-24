" basic setups
	set nocompatible	" explicitly get out of vi-compatible mode
	set noexrc		" don't use local version of .(g)vimrc, .exrc
	set background=dark	" we plan to use a dark background
	syntax on		" syntax highlighting on
	set autoindent		" autoindent
	set modeline            " modeline interpret

" General stuff
	filetype plugin indent on	" load filetype plugins/indent settings
	set backspace=indent,eol,start	" make backspace a more flexible
	set fileformats=unix,dos,mac	" support all three, in this order
	set iskeyword+=_,$,@,%,#	" none of these are word dividers
"	set mouse=a			" use mouse everywhere
	set noerrorbells		" don't make noise
	set whichwrap=b,s,h,l,<,>,~,[,]	" everything wraps
	"             | | | | | | | | |
	"             | | | | | | | | +-- "]" Insert and Replace
	"             | | | | | | | +-- "[" Insert and Replace
	"             | | | | | | +-- "~" Normal
	"             | | | | | +-- <Right> Normal and Visual
	"             | | | | +-- <Left> Normal and Visual
	"             | | | +-- "l" Normal and Visual (not recommended)
	"             | | +-- "h" Normal and Visual (not recommended)
	"             | +-- <Space> Normal and Visual
	"             +-- <BS> Normal and Visual
	set hlsearch			" highlight searches
	set incsearch			" highlight as you type your search
	set laststatus=2		" always show the status line
	set lazyredraw			" do not redraw while running macros
	set linespace=0			" don't insert any extra pixel lines
	set nostartofline		" leave my cursor where it was
					" betweens rows
"	set number			" number lines
"	set ruler			" show where we are
	set showmatch			" show matching brackets
	set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%l,%v]
	"              | | | | |  |   |      |  |     |  |
	"              | | | | |  |   |      |  |     |  + current column
	"              | | | | |  |   |      |  |     +-- current line
	"              | | | | |  |   |      |  +-- current % into file
	"              | | | | |  |   |      +-- current syntax in square brackets
	"              | | | | |  |   +-- current fileformat
	"              | | | | |  +-- number of lines
	"              | | | | +-- preview flag in square brackets
	"              | | | +-- help flag in square brackets
	"              | | +-- readonly flag in square brackets
	"              | +-- modified flag in square brackets
	"              +-- full path to file in the buffer
" Colors
	set t_Co=256
	colorscheme calmar256-dark

