"ativates filetype detection
filetype plugin indent on

" activates syntax highlighting among other things
syntax on
set background=dark

" allows you to deal with multiple unsaved
" buffers simultaneously without resorting
" to misusing tabs
set hidden

" just hit backspace without this one and
" see for yourself
set backspace=indent,eol,start

" Search enhancing
set incsearch
set hlsearch

" Proper text wrap
" set tw=72

" Press F12 before pasting text to avoid crazy indentation
set pastetoggle=<F12>

" Show matching brackets.
set showmatch
" Show line, col pos and %document
set ruler

" Proper tab value for Python
set tabstop=4
set expandtab
set autoindent

" Automatically assign shebang to files
augroup Shebang
    autocmd BufNewFile *.sh     0put =\"#!/bin/bash\"|$
    autocmd BufNewFile *.py     0put =\"#!/usr/bin/env python3\"|$
    autocmd BufNewFile *.plt    0put =\"#!/usr/bin/env gnuplot\"|$
    autocmd BufNewFile *.gnu    0put =\"#!/usr/bin/env gnuplot\"|$
augroup END

" Set syntax properly
augroup syntax
    au  BufNewFile,BufReadPost *.lmp    so ~/.vim/syntax/lammps.vim
    au  BufNewFile,BufReadPost in.*     so ~/.vim/syntax/lammps.vim
    au  BufNewFile,BufReadPost *.gnu    so ~/.vim/syntax/gnuplot.vim
    au  BufNewFile,BufReadPost *.plt    so ~/.vim/syntax/gnuplot.vim
augroup END

" Set proper textwidth when writing a git commit
au FileType gitcommit set tw=72
autocmd BufNewFile README set textwidth=72

" Set line numbers
set number

" Deal with swap files NB: Override danger!
set swapfile
set dir=~/.vim/swp
