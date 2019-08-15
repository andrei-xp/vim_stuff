VIM_CONFIG_DIR="${HOME}/.vim"
DATE=$(date '+%Y-%m-%d_%H:%M:%S')

function install_pathogen() {
    [ ! -d ${VIM_CONFIG_DIR} ] && \
    mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim || \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
}

function create_colors_dir() {
    [ -d ${VIM_CONFIG_DIR} ] && \
        mkdir -p ~/.vim/colors

    git clone https://github.com/tomasr/molokai.git                 ~/.vim/colors/molokai
    git clone https://github.com/partounian/custom-lucario.git      ~/.vim/colors/custom-lucario

    # Copy actual color file to ~/.vim/colors
    find ~/.vim/colors/ -iname "*.vim" -exec cp {} ~/.vim/colors \;
}

function install_bundles() {

    git clone https://github.com/jiangmiao/auto-pairs.git               ~/.vim/bundle/auto-pairs
    git clone https://github.com/Yggdroot/indentLine.git                ~/.vim/bundle/indentLine
    git clone https://github.com/vim-airline/vim-airline.git            ~/.vim/bundle/vim-airline
    git clone https://github.com/enricobacis/vim-airline-clock.git      ~/.vim/bundle/vim-airline-clock
    git clone https://github.com/tpope/vim-commentary.git               ~/.vim/bundle/vim-commentary.git
    git clone https://github.com/thaerkh/vim-indentguides.git           ~/.vim/bundle/vim-indentguides.git
    git clone https://github.com/jeffkreeftmeijer/vim-numbertoggle.git  ~/.vim/bundle/vim-numbertoggle
    git clone https://github.com/sheerun/vim-polyglot.git               ~/.vim/bundle/vim-polyglot
    git clone https://github.com/tpope/vim-sensible.git                 ~/.vim/bundle/vim-sensible
    git clone https://github.com/reedes/vim-colors-pencil.git           ~/.vim/bundle/vim-colors-pencil
}

function create_vimrc() {
    [ -f ~/.vimrc ] || \
    [ ! -f ~/.vimrc] && \
    mv ~/.vimrc{,.${DATE}} && \
    tee ~/.vimrc << EOF
execute pathogen#infect()

" Sane defaults
syntax enable
set autoindent
set autoread                                                 " reload files when changed on disk, i.e. via `git checkout`
set backspace=2                                              " Fix broken backspace in some setups
set backupcopy=yes                                           " see :help crontab
set clipboard=unnamed                                        " yank and paste with the system clipboard
set directory-=.                                             " don't store swapfiles in the current directory
set encoding=utf-8
set expandtab                                                " expand tabs to spaces
set ignorecase                                               " case-insensitive search
set incsearch                                                " search as you type
set laststatus=2                                             " always show statusline
set list                                                     " show trailing whitespace
set listchars=tab:▸\ ,trail:·
set number                                                   " show line numbers
set ruler                                                    " show where you are
set scrolloff=3                                              " show context above/below cursorline
set shiftwidth=2                                             " normal mode indentation commands use 2 spaces
set showcmd
set smartcase                                                " case-sensitive search if any caps
set softtabstop=2                                            " insert mode tab and backspace use 2 spaces
set tabstop=4                                                " actual tabs occupy 8 characters
set wildmenu                                                 " show a navigable menu for tab completion
set wildmode=longest,list,full
set cursorline                                               " highlight current line
set noeb vb t_vb=
filetype on
filetype plugin on
filetype plugin indent on

" Set GUI options -- disable scrollbars [buffer and window]
" :set guioptions-=l
" set guioptions-=L
" set guioptions-=r
" set guioptions-=R

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Toggle PASTE mode with F2 key
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Default theme
colorscheme molokai

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-c>"

" YouCompleteMe extra settings
let g:ycm_autoclose_preview_window_after_completion=1

" Specific file settings
" Proper python indendation
au BufNewFile,BufRead *.py,*.sh,*.rb
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" Clock
let g:airline#extensions#clock#format = '%H:%M'
let g:airline_theme = 'pencil'
EOF
}

install_pathogen
create_colors_dir
install_bundles
create_vimrc
