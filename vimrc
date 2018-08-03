" Preamble ============================================================= {{{



" Remove vi compatibility
set nocompatible

" Setup Pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
if exists("g:loaded_pathogen")
  execute pathogen#infect()
  execute pathogen#helptags()
endif

" Move undo files to vim directory
set undodir=~/.vim/local/undo//

" Enable backups
set backup
set backupdir=~/.vim/local/backup//

" Swap files
set noswapfile
set directory=~/.vim/local/swap//

" View files
" Makes vim save state: folds, cursor, etc.
set viewdir=~/.vim/local/view//
augroup RememberLastView
  au!
  au BufWinLeave * silent! mkview
  au BufWinEnter * silent! loadview
augroup end



" ====================================================================== }}}
" Basic keybindings ==================================================== {{{



" Use semicolon for commands
nnoremap ; :

" Exit insert mode with shift-space
inoremap <S-Space> <esc>

" Leaders
let mapleader = ","
let maplocalleader = "\\"



" ====================================================================== }}}
" Searching and motion ================================================= {{{



" Move by screen lines, not file lines
nnoremap j gj
nnoremap k gk
nnoremap ^ g^
nnoremap $ g$
nnoremap 0 g0

" Swap the original line motions to g- prefixed commands
nnoremap gj j
nnoremap gk k
nnoremap g^ ^
nnoremap g$ $
nnoremap g0 0



" Search case
set ignorecase
set smartcase

" Highlight search terms
set hlsearch

" Search as you type
set incsearch

" Default to global replace
set gdefault

" Clear search higlights
nnoremap <leader><space> :noh<cr>



" ====================================================================== }}}
" Folding ============================================================== {{{



" Enable code folding
set foldenable

" Don't autofold
set foldlevelstart=99
set foldlevel=99

" Folding method
set foldmethod=marker

" Folding function
function! MyFoldText()
  let line = getline(v:foldstart)

  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces
  let onetab = strpart(' ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')

  let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction
set foldtext=MyFoldText()




" Use space to toggle folds
nnoremap <Space> za
vnoremap <Space> za



" ====================================================================== }}}
" Editing vimrc ======================================================== {{{



" Quickly open vimrc
nnoremap <leader>rc :e ~/.vim/vimrc<cr>

" Reload vimrc on save
autocmd BufWritePost vimrc mkview | source % | loadview



" ====================================================================== }}}
