set ffs=unix,dos,mac        " set file formats
set number                  " line numbers
set background=dark         " background
set t_Co=256
set backspace=2
"colorscheme vividchalk      " theme
execute pathogen#infect('bundle/{}')
call pathogen#helptags()
filetype off
syntax on
filetype plugin indent on

" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
   au!
   autocmd BufReadPost *
            \ if expand("<afile>:p:h") !=? $TEMP |
            \   if line("'\"") > 1 && line("'\"") <= line("$") |
            \     let JumpCursorOnEdit_foo = line("'\"") |
            \     let b:doopenfold = 1 |
            \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
            \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
            \        let b:doopenfold = 2 |
            \     endif |
            \     exe JumpCursorOnEdit_foo |
            \   endif |
            \ endif
   " Need to postpone using "zv" until after reading the modelines.
   autocmd BufWinEnter *
            \ if exists("b:doopenfold") |
            \   exe "normal zv" |
            \   if(b:doopenfold > 1) |
            \       exe  "+".1 |
            \   endif |
            \   unlet b:doopenfold |
            \ endif
augroup END

" Necesary for lots of cool vim things
set nocompatible

" This shows what you are typing as a command.  I love this!
set showcmd

" Folding Stuffs
set foldmethod=marker

" Needed for Syntax Highlighting and stuff
"filetype on
"filetype plugin on
"syntax enable
set grepprg=grep\ -nH\ $*

" Who doesn't like autoindent?
set autoindent

" Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full

" Enable mouse support in console
set mouse=a

" Ignoring case is a fun trick
set ignorecase

" And so is Artificial Intellegence!
set smartcase

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <Esc>

" Keep all the temporary and backup files in one place
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" For converting tabs to spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Single character insert using space
nmap <Space> i_<Esc>r

" Visual selection inserts tabs
vmap <Tab> >gv
vmap <S-Tab> <gv

" Markdown - disable folding
let g:vim_markdown_folding_disabled=1

" Automatically wrap long git commit messages
au FileType gitcommit set tw=72

" Airline configuration
set laststatus=2
set guifont=Sauce\ Code\ Powerline:h10
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

colorscheme gotham256       " theme

" NERDTree pluging
autocmd VimEnter * NERDTree
autocmd BufEnter * NERDTreeMirror

" Tab scrolling keybindings
map  <C-l> :tabn<CR>
map  <C-h> :tabp<CR>
map  <C-i> :tabnew<CR>

" TagBar key binding
nmap <F8> :TagbarToggle<CR>

"CTRL-t to toggle tree view with CTRL-t
nmap <silent> <C-t> :NERDTreeToggle<CR>
""Set F2 to put the cursor to the nerdtree
nmap <silent> <F2> :NERDTreeFind<CR>

" Rust env
"set hidden
let g:racer_cmd = "/Users/jalmeida/git/racer/target/release/racer"
let $RUST_SRC_PATH="/Users/jalmeida/git/rust/src/"


