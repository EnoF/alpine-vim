FROM jare/vim-bundle:latest

USER root

RUN rm -rf $UHOME/bundle/YouCompleteMe

# Vim plugins deps
RUN apk --update add \
    nodejs \
    the_silver_searcher \
# YouCompleteMe
    && apk add --virtual build-deps \
    build-base \
    cmake \
    go \
    llvm \
    perl \
    python-dev \
    && git clone --depth 1  https://github.com/Valloric/YouCompleteMe \
    $UHOME/bundle/YouCompleteMe/ \
    && cd $UHOME/bundle/YouCompleteMe \
    && git submodule update --init --recursive \
    && $UHOME/bundle/YouCompleteMe/install.py --gocode-completer --tern-completer

# Typescript
RUN npm install -g typescript

USER $UNAME

# Plugins
RUN cd $UHOME/bundle/ \
# Theme
    && git clone --depth 1 https://github.com/joshdick/onedark.vim \
    && git clone --depth 1 https://github.com/leafgarland/typescript-vim \
    && git clone --depth 1 https://github.com/editorconfig/editorconfig-vim

COPY my.vimrc /ext/.vimrc

# List of Vim plugins to disable
ENV DISABLE=""

ENTRYPOINT ["sh", "/usr/local/bin/run"]
