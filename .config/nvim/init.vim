" Automatic installation - required before plug#begin
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"""""""""""""""""""
" My plugins here "
"""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')

" NERDTree file explorer
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Gotham colorscheme
Plug 'whatyouhide/vim-gotham'

" Airline for those killer status and tabline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Rust syntax highlighting
Plug 'rust-lang/rust.vim'

" Ctrl-P file search
Plug 'kien/ctrlp.vim'

" ALE lint engine
Plug 'w0rp/ale'

" YouCompleteMe completion
Plug 'Valloric/YouCompleteMe'

" Oceanic-Next theme
Plug 'mhartington/oceanic-next'

" Editor config
Plug 'editorconfig/editorconfig-vim'

" Relative line numbers
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" TagBar - function definition list
Plug 'majutsushi/tagbar'

call plug#end()

""""""""""""""""""""""""""
" Miscellaneous settings "
""""""""""""""""""""""""""

" Line numbers
set nu

" Converting tabs to spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Mouse support
set mouse=a

" Auto-indenting
set autoindent

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

""""""""""""""""
" Plugin Setup "
""""""""""""""""

" Airline plugin settings
set laststatus=2
set guifont=Sauce\ Code\ Powerline:h10
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Ctrl-P key mapping
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" YouCompleteMe settings
"let g:python_host_prog = '/usr/local/bin/python'

"""""""""""""""""
" Highlightings "
"""""""""""""""""

" Javascript ES6 highlighting for .jsm
au BufNewFile,BufRead *.jsm set filetype=javascript

" Syntastic C++11 support
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

" Ale (Asynchronous Lint Engine) env
" Switch these two options when using Cargo
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1

""""""""""
" Themes "
""""""""""

" Gotham
"colorscheme gotham

" OceanicNext
if (has("termguicolors"))
 set termguicolors
endif
colorscheme OceanicNext
let g:airline_theme='oceanicnext'

""""""""""""""""
" Key Bindings "
""""""""""""""""

" Tab scrolling
nmap <C-]> :tabn<CR>
nmap <C-[> :tabp<CR>
nmap <Tab> :tabnew<CR>

" Buffer scrolling
nmap <C-H> :bprevious!<CR>
nmap <C-L> :bnext!<CR>
nmap <C-I> :enew<CR>

" Saving current buffer
noremap <C-s> :w<CR>

" Buffer list
nnoremap <F5> :buffers<CR>:buffer<Space>

" CTRL-t to toggle tree view with CTRL-t
nmap <silent> <C-t> :NERDTreeToggle<CR>

" TagBar keybinding
nmap <F8> :TagbarToggle<CR>

" Correct indentation (global)
nmap <F7> gg=G

" Visual insert/remove with tab
vmap <Tab> >gv
vmap <S-Tab> <gv

" Escape from insert mode
inoremap jj <Esc>

" Single character insert using space
nmap <Space> i_<Esc>r

" Ignoring case and adding smart case
set ignorecase
set smartcase

" Mac OS X clipboard support
set clipboard=unnamed
