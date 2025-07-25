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

" Tree-sitter for language support
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Airline for those killer status and tabline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Rust syntax support
Plug 'rust-lang/rust.vim'

" Elixir syntax support
"Plug 'elixir-lang/vim-elixir'
"Plug 'thinca/vim-ref' " doc support
"Plug 'kbrw/elixir.nvim', { 'do': 'yes \| ./install.sh' } " auto-complete

" Auto-completion
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

" Fuzz-finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Oceanic-Next theme
Plug 'mhartington/oceanic-next'

" Editor config
Plug 'editorconfig/editorconfig-vim'

" Relative line numbers
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" Dating incrementing support
Plug 'tpope/vim-speeddating'

" Vim Surround
Plug 'tpope/vim-surround'

"""""""""""""""""""
" Version control "
"""""""""""""""""""

" Git-coauthor; requires fzf
Plug 'maxjacobson/vim-fzf-coauthorship'

" Show files touched compared to version control
Plug 'airblade/vim-gitgutter'

" A helpful syntax highlighter for jjdescription files
Plug 'avm99963/vim-jjdescription'

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
set guifont=FiraCode:h10
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

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

" Gotham colorscheme
Plug 'whatyouhide/vim-gotham'

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
"nmap <Tab> :tabnew<CR>

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

" fzf for fuzzy file search
nmap <C-p> :Files<CR>

" Visual insert/remove with tab
vmap <Tab> >gv
vmap <S-Tab> <gv

" Escape from insert mode
inoremap jj <Esc>

" Single character insert using space
nmap <Space> i_<Esc>r

" Move to next and prev whitespace
nmap <C-l> f<Space>
nmap <C-h> F<Space>

" Ignoring case and adding smart case
set ignorecase
set smartcase

" Mac OS X clipboard support
set clipboard=unnamed

" Fuck you swap files!
set noswapfile

" Turn off the bell because it sucks to hear this when in IntelliJ IDEs
set visualbell

" Coauthorship key binding
nmap <silent> <C-g> :Coauthorship<CR>
