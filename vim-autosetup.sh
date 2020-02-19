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

function copy_vimrc() {

    test -f ~/.vimrc && mv ~/.vimrc{,.${DATE}}
    cp dot_files/vimrc ~/.vimrc
}

install_pathogen
create_colors_dir
install_bundles
copy_vimrc
