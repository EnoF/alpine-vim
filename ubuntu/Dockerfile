FROM ubuntu:latest

MAINTAINER EnoF

# Install Git so that the plugins can be installed first
RUN apt-get update \
    && apt-get -y install git

# Plugins
RUN mkdir -p /etc/vim/bundle \
    && cd /etc/vim/bundle/ \
    && git clone --depth 1 https://github.com/pangloss/vim-javascript \
    && git clone --depth 1 https://github.com/leafgarland/typescript-vim \
    && git clone --depth 1 https://github.com/scrooloose/nerdcommenter \
    && git clone --depth 1 https://github.com/Raimondi/delimitMate \
    && git clone --depth 1 https://github.com/nathanaelkane/vim-indent-guides \
    && git clone --depth 1 https://github.com/groenewege/vim-less \
    && git clone --depth 1 https://github.com/othree/html5.vim html5 \
    && git clone --depth 1 https://github.com/elzr/vim-json \
    && git clone --depth 1 https://github.com/bling/vim-airline \
    && git clone --depth 1 https://github.com/easymotion/vim-easymotion \
    && git clone --depth 1 https://github.com/mbbill/undotree \
    && git clone --depth 1 https://github.com/majutsushi/tagbar \
    && git clone --depth 1 https://github.com/vim-scripts/EasyGrep \
    && git clone --depth 1 https://github.com/jlanzarotta/bufexplorer \
    && git clone --depth 1 https://github.com/kien/ctrlp.vim \
    && git clone --depth 1 https://github.com/scrooloose/nerdtree \
    && git clone --depth 1 https://github.com/jistr/vim-nerdtree-tabs \
    && git clone --depth 1 https://github.com/scrooloose/syntastic \
    && git clone --depth 1 https://github.com/tomtom/tlib_vim \
    && git clone --depth 1 https://github.com/marcweber/vim-addon-mw-utils \
    && git clone --depth 1 https://github.com/vim-scripts/taglist.vim \
    && git clone --depth 1 https://github.com/terryma/vim-expand-region \
    && git clone --depth 1 https://github.com/tpope/vim-fugitive \
    && git clone --depth 1 https://github.com/airblade/vim-gitgutter \
    && git clone --depth 1 https://github.com/fatih/vim-go \
    && git clone --depth 1 https://github.com/plasticboy/vim-markdown \
    && git clone --depth 1 https://github.com/michaeljsmith/vim-indent-object \
    && git clone --depth 1 https://github.com/terryma/vim-multiple-cursors \
    && git clone --depth 1 https://github.com/tpope/vim-repeat \
    && git clone --depth 1 https://github.com/tpope/vim-surround \
    && git clone --depth 1 https://github.com/vim-scripts/mru.vim \
    && git clone --depth 1 https://github.com/vim-scripts/YankRing.vim \
    && git clone --depth 1 https://github.com/tpope/vim-haml \
    && git clone --depth 1 https://github.com/SirVer/ultisnips \
    && git clone --depth 1 https://github.com/honza/vim-snippets \
    && git clone --depth 1 https://github.com/derekwyatt/vim-scala \
    && git clone --depth 1 https://github.com/christoomey/vim-tmux-navigator \
    && git clone --depth 1 https://github.com/ekalinin/Dockerfile.vim \
    && git clone --depth 1 https://github.com/editorconfig/editorconfig-vim \
    && git clone --depth 1  https://github.com/Valloric/YouCompleteMe \
    && git clone --depth 1 https://github.com/joshdick/onedark.vim onedark \
    && cd /etc/vim/bundle/YouCompleteMe \
    && git submodule update --init --recursive

# Install vim and all dependencies for our plugins
RUN apt-get -y install vim \
    vim-gnome \
    xclip \
    exuberant-ctags \
    silversearcher-ag \
    curl \
    zsh \
    npm \
    python2.7 \
    python-dev \
    cmake

# User config
ENV UID="1000" \
    UNAME="developer" \
    GID="1000" \
    GNAME="developer" \
    SHELL="/bin/bash" \
    UHOME=/home/developer

# Used to configure YouCompleteMe
ENV GOROOT="/usr/lib/go"
ENV GOBIN="$GOROOT/bin"
ENV GOPATH="$UHOME/workspace"
ENV PATH="$PATH:$GOBIN:$GOPATH/bin"

RUN useradd -ms $SHELL $UNAME

# Install oh my zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Initialize all directories necessary for the bundles
RUN mkdir -p $UHOME/workspace \
    $GOROOT \
    $UHOME/.vim_runtime/temp_dirs \
    /etc/vim/bundle/.vim/autoload \
    /etc/vim/bundle/.vim_runtime/temp_dirs

RUN cd /usr/lib \
    && curl https://storage.googleapis.com/golang/go1.9.2.linux-amd64.tar.gz --output go1.9.2.linux-amd64.tar.gz \
    && tar -C /usr/lib -xvzf go1.9.2.linux-amd64.tar.gz \
    && rm go1.9.2.linux-amd64.tar.gz

# Initialize Go and JS/Typescript completion
RUN /etc/vim/bundle/YouCompleteMe/install.py --gocode-completer --tern-completer

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get -y install nodejs

# Install the typescript specific dependencies
RUN npm install -g typescript yarn git+https://github.com/Perlence/tstags.git

# Create the vimrc
COPY .vimrc /etc/vimrc.local
RUN  curl -s \
     https://raw.githubusercontent.com/amix/vimrc/master/vimrcs/basic.vim \
     >> /etc/vim/vimrc.local \
     && curl -s \
     https://raw.githubusercontent.com/amix/vimrc/master/vimrcs/extended.vim \
     >> /etc/vim/vimrc.local \
     && sed -i '/colorscheme peaksea/d' /etc/vim/vimrc.local \
     && sed -i '/colorscheme solarized/d' /etc/vim/vimrc.local \
     && cat /etc/vimrc.local >> /etc/vim/vimrc.local

# Install Pathogen
RUN curl -LSso \
    /etc/vim/bundle/.vim/autoload/pathogen.vim \
    https://tpo.pe/pathogen.vim

# Pathogen help tags generation
RUN vim -E -c 'execute pathogen#helptags()' -c q ; return 0

ENV TERM=xterm-256color

WORKDIR $UHOME/workspace

USER $UNAME

ENTRYPOINT ["vim"]
